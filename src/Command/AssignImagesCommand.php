<?php

namespace App\Command;

use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Helper\ProgressBar;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;

#[AsCommand(
    name: 'app:assign-images',
    description: 'Attribue des images aléatoires à tous les produits',
)]
class AssignImagesCommand extends Command
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private ProductRepository $productRepository,
        private ParameterBagInterface $parameterBag,
        private SluggerInterface $slugger,
        private HttpClientInterface $httpClient
    ) {
        parent::__construct();
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $products = $this->productRepository->findAll();
        $uploadDir = $this->parameterBag->get('products_directory');

        if (!is_dir($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }

        $io->title('Attribution d\'images aléatoires aux produits');
        
        if (empty($products)) {
            $io->warning('Aucun produit trouvé dans la base de données.');
            return Command::SUCCESS;
        }

        $progressBar = new ProgressBar($output, count($products));
        $progressBar->start();

        $diverseKeywords = ['shoes', 'shirt', 'watch', 'laptop', 'phone', 'bag', 'hat', 'jewelry', 'perfume', 'camera', 'chair', 'table', 'lamp', 'sofa', 'bike', 'car', 'book', 'toy', 'tool', 'sports', 'instrument', 'bicycle', 'glasses', 'wallet', 'belt', 'scarf'];

        foreach ($products as $index => $product) {
            // Using Picsum Photos for GUARANTEED uniqueness. 
            // LoremFlickr was returning duplicate placeholders.
            $imageUrl = sprintf('https://picsum.photos/seed/%s/800/800', uniqid());
            
            try {
                $response = $this->httpClient->request('GET', $imageUrl);
                
                if ($response->getStatusCode() === 200) {
                    $imageContent = $response->getContent();
                    
                    $extension = 'jpg';
                    // Essayer de deviner l'extension via le content-type
                    $headers = $response->getHeaders();
                    $contentType = $headers['content-type'][0] ?? 'image/jpeg';
                    
                    if (str_contains($contentType, 'png')) {
                        $extension = 'png';
                    } elseif (str_contains($contentType, 'webp')) {
                        $extension = 'webp';
                    }

                    $filename = $this->slugger->slug($product->getName()) . '-' . uniqid() . '.' . $extension;
                    $filePath = $uploadDir . '/' . $filename;

                    file_put_contents($filePath, $imageContent);
                    $product->setImageName($filename);
                } else {
                    $io->error(sprintf('Erreur HTTP %d pour le produit "%s"', $response->getStatusCode(), $product->getName()));
                }
            } catch (\Exception $e) {
                $io->error(sprintf('Erreur pour le produit "%s": %s', $product->getName(), $e->getMessage()));
            }

            $progressBar->advance();
            // Petit délai pour ne pas trop solliciter le service distant
            usleep(100000); 
        }

        $this->entityManager->flush();
        $progressBar->finish();
        
        $io->newLine(2);
        $io->success('Tous les produits ont reçu une nouvelle image aléatoire !');

        return Command::SUCCESS;
    }
}

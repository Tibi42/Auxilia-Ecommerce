import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    static targets = ['slide'];
    
    static values = {
        index: { type: Number, default: 0 },
        autoPlay: { type: Boolean, default: true },
        interval: { type: Number, default: 5000 }
    };
    
    connect() {
        this.showSlide(this.indexValue);
        
        if (this.autoPlayValue) {
            this.startAutoPlay();
        }
    }
    
    disconnect() {
        if (this.intervalId) {
            clearInterval(this.intervalId);
        }
    }
    
    next() {
        this.indexValue = (this.indexValue + 1) % this.slideTargets.length;
        this.showSlide(this.indexValue);
        this.resetAutoPlay();
    }
    
    previous() {
        this.indexValue = (this.indexValue - 1 + this.slideTargets.length) % this.slideTargets.length;
        this.showSlide(this.indexValue);
        this.resetAutoPlay();
    }
    
    showSlide(index) {
        this.slideTargets.forEach((slide, i) => {
            if (i === index) {
                slide.classList.add('active');
            } else {
                slide.classList.remove('active');
            }
        });
    }
    
    startAutoPlay() {
        this.intervalId = setInterval(() => {
            this.next();
        }, this.intervalValue);
    }
    
    resetAutoPlay() {
        if (this.intervalId) {
            clearInterval(this.intervalId);
        }
        if (this.autoPlayValue) {
            this.startAutoPlay();
        }
    }
}


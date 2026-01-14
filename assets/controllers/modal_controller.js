import { Controller } from '@hotwired/stimulus';

/*
 * This is an example Stimulus controller!
 *
 * Any element with a data-controller="modal" attribute will cause
 * this controller to be executed. The name "modal" comes from the filename:
 * modal_controller.js -> "modal"
 *
 * Delete this file or adapt it for your use!
 */
export default class extends Controller {
    static targets = ["dialog", "title", "description", "price", "addToCartLink"];

    connect() {
        console.log("Modal controller connected");
    }

    open(event) {
        event.preventDefault();
        const button = event.currentTarget;
        const data = button.dataset;

        this.titleTarget.textContent = data.name;
        this.descriptionTarget.textContent = data.description || "Aucune description disponible.";
        this.priceTarget.textContent = data.price + " €";
        this.addToCartLinkTarget.setAttribute('href', data.addToCartUrl);

        this.dialogTarget.classList.add('active');
    }

    close(event) {
        if (event) event.preventDefault();
        this.dialogTarget.classList.remove('active');
    }

    closeBackground(event) {
        if (event.target === this.dialogTarget) {
            this.close();
        }
    }
}

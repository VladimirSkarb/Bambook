import { Component} from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { OfferService } from '../../../services/offer.service';

@Component({
  selector: 'app-offer',
  templateUrl: './offer.component.html',
  styleUrls: ['./offer.component.css']
})
export class OfferComponent {
  offer;

  constructor(private offerService: OfferService,
              private activatedRoute: ActivatedRoute){
    this.offerService.getOfferById(this.activatedRoute.snapshot.params['id'])
      .then((resp) => {
        this.offer = resp;
        console.log(this.offer);
      });
  }

  subscribeOffer() {
    console.log('realize subscribe method here')
  }

}

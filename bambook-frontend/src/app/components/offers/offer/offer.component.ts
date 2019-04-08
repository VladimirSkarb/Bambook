import { Component} from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { OfferService } from '../../../services/offer.service';
import {HttpClient} from "@angular/common/http";

@Component({
  selector: 'app-offer',
  templateUrl: './offer.component.html',
  styleUrls: ['./offer.component.css']
})
export class OfferComponent {
  offer;
  offer_subscriptions;
  offer_id = this.activatedRoute.snapshot.params['id'];

  constructor(private offerService: OfferService,
              private activatedRoute: ActivatedRoute,
              private http: HttpClient){

    http.get((`http://localhost:3000/api/v1/offers/${this.offer_id}/subscriptions`))
      .subscribe(res => this.offer_subscriptions = res);
    console.log(this.offer_subscriptions)

    this.offerService.getOfferById(this.offer_id)
      .then((resp) => {
        this.offer = resp;
        console.log(this.offer);
      });
  }

  subscribeOffer() {
    this.offerService.subscribeToOffer(this.offer_id)
      .subscribe((resp) => {
        this.offer = resp;
        console.log(this.offer);
      });
  }
}

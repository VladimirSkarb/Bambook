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

  constructor(private offerService: OfferService,
              private activatedRoute: ActivatedRoute,
              private http: HttpClient){

    const offer_id = this.activatedRoute.snapshot.params['id']

    http.get((`http://localhost:3000/api/v1/offers/${offer_id}/subscriptions`))
      .subscribe(res => this.offer_subscriptions = res);
    console.log(this.offer_subscriptions)

    this.offerService.getOfferById(this.activatedRoute.snapshot.params['id'])
      .then((resp) => {
        this.offer = resp;
        console.log(this.offer);
      });
  }

  subscribeOffer() {
    this.offerService.subscribeToOffer(this.activatedRoute.snapshot.params['id'])
      .subscribe((resp) => {
        this.offer = resp;
        console.log(this.offer);
      });
  }

  // offerSubscriptions() {
  //   this.offerService.getOfferSubscriptions(this.activatedRoute.snapshot.params['id'])
  //     .subscribe((resp) => {
  //       this.offer_subscriptions = resp;
  //       console.log(this.offer_subscriptions);
  //     });
  // }

  // getOfferSubscriptions(offerId) {
  //   let offer_id = {
  //     offer_id: offerId
  //   };
  //   return this.http.get((`${this.apiUrl}/${offerId}/subscriptions`));
  // }
}

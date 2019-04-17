import { Component} from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { OfferService } from '../../../services/offer.service';
import {HttpClient, HttpHeaders} from '@angular/common/http';
import { AuthService } from '../../../services/auth.service';

@Component({
  selector: 'app-offer',
  templateUrl: './offer.component.html',
  styleUrls: ['./offer.component.css']
})
export class OfferComponent {
  offer;
  offer_subscriptions;
  offer_id = this.activatedRoute.snapshot.params['id'];
  user_profile: any;

  authToken =  localStorage.getItem('access_token');

  httpOptions = {
    headers: new HttpHeaders({ 'Authorization': this.authToken })
  };

  constructor(private offerService: OfferService,
              private activatedRoute: ActivatedRoute,
              private http: HttpClient,
              private auth: AuthService) {

    if (this.auth.loggedIn) {
      this.http.get((`http://localhost:3000/api/v1/profile`), this.httpOptions)
        .subscribe(res => this.user_profile = res);
    }
    this.user_profile =  null;

    http.get((`http://localhost:3000/api/v1/offers/${this.offer_id}/subscriptions`))
      .subscribe(res => this.offer_subscriptions = res);

    this.offerService.getOfferById(this.offer_id)
      .then((resp) => {
        this.offer = resp;
      });
  }

  subscribeOffer() {
    this.offerService.subscribeToOffer(this.offer_id)
      .subscribe((resp) => {
        this.offer_subscriptions.users.push(resp);
        console.log(this.offer_subscriptions)
      });
  }

  sameUser() {
    return this.offer.user_id === this.user_profile.user.id;
  }

}

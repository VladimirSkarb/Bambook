import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { OfferService } from '../../../services/offer.service';
import { AuthService } from '../../../services/auth.service';

@Component({
  selector: 'app-add-offer',
  templateUrl: './add-offer.component.html',
  styleUrls: ['./add-offer.component.css']
})
export class AddOfferComponent implements OnInit {

  link: string;
  deadline: string;
  minimum_quantity: number;

  message: string;

  constructor(private offerService: OfferService,
              private router: Router,
              private auth: AuthService) { }

  ngOnInit() {
  }

  submitOffer() {
    if ((this.link && this.link != '') &&
      (this.deadline && this.deadline != '') &&
      (this.minimum_quantity && this.minimum_quantity != null))
    {
      const offer = {
        offer:
          {
            link: this.link,
            deadline: this.deadline,
            minimum_quantity: this.minimum_quantity
          }
      };
      this.offerService.addOffer(offer).subscribe((resp: any) => {

        if (resp.offer) {
          this.router.navigate(['/offers/' + resp.offer.id]);
          console.log('The offer was created')
        }
        else {
          console.log(resp.message);
        }
      });
    } else {
      this.message = 'Please fill in all fields';
    }
  }
}

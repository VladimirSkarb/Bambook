import { Component, OnInit } from '@angular/core';
import { HttpClient} from '@angular/common/http';

@Component({
  selector: 'app-offers',
  templateUrl: './offers.component.html',
  styleUrls: ['./offers.component.css']
})
export class OffersComponent implements OnInit {
  title = 'Offers';
  offers;
  constructor(private http: HttpClient) {
    http.get('http://localhost:3000/api/v1/offers')
      .subscribe(res => this.offers = res);
  }

  ngOnInit() {
  }

}

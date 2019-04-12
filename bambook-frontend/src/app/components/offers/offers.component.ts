import { Component } from '@angular/core';
import { HttpClient, HttpParams} from '@angular/common/http';
import { PagerService } from '../../services/pager.service';

@Component({
  selector: 'app-offers',
  templateUrl: './offers.component.html',
  styleUrls: ['./offers.component.css']
})
export class OffersComponent {
  title = 'Offers';
  offers;
  offers_count;
  current_page;
  pager: any = {};

  constructor(private http: HttpClient, private pagerService: PagerService ) {
    http.get('http://localhost:3000/api/v1/offers').toPromise().then((resp) => {
      this.offers = resp;
      this.offers_count = this.offers.offers_count;
      this.setPage(1)
    });
  }

  getPage(page: number) {
    let params = new HttpParams({fromObject:{page: `${page}`}});
    return this.http.get(`http://localhost:3000/api/v1/offers`, {params}).toPromise().then((resp) => {
      this.offers = resp;
      this.setPage(page)
    });
  }

  setPage(page: number) {
    // get pager object from service
    this.pager = this.pagerService.getPager(this.offers_count, page);
  }

}

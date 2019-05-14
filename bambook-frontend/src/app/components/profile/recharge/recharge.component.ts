import { Component, OnInit } from '@angular/core';
// import {HttpClient, HttpHeaders} from '@angular/common/http';
import {RechargeService} from '../../../services/recharge.service';
import {Router} from '@angular/router';
import {AuthService} from '../../../services/auth.service';
// import {HttpHeaders} from "@angular/common/http";

@Component({
  selector: 'app-recharge',
  templateUrl: './recharge.component.html',
  styleUrls: ['./recharge.component.css']
})
export class RechargeComponent implements OnInit {
  sum: number;
  email: string;

  message: string;
  // authToken =  localStorage.getItem('access_token');
  //
  // httpOptions = {
  //   headers: new HttpHeaders({ 'Authorization': this.authToken })
  // };

  constructor(private rechargeService: RechargeService,
              private router: Router,
              private auth: AuthService) { }

  ngOnInit() {
  }

  submitRecharge() {
    if (this.sum && this.sum != null) {
      this.rechargeService.addRecharge(this.sum).subscribe((resp: any) => {

        if (!resp.success) {
          this.router.navigateByUrl('/profile/recharges');
        } else {
          console.log(resp.message);
        }
      });
    } else {
      this.message = 'Please fill in all fields';
    }
  }
}

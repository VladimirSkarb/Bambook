import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { JwtService } from '../../../jwt.service';
import {ValidateService} from '../../../services/validate.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  email: string;
  password: string;
  message: string;


  constructor(private jwtService: JwtService, private router: Router, private validateService: ValidateService) {
  }

  ngOnInit() {
  }

  login() {
    if (!this.email || this.email == '') {
      this.message = 'Please enter your email.';
    } else if (!this.password || this.password == '') {
      this.message = 'Please enter your password.';
    } else if (!this.validateService.validateEmail(this.email)) {
      this.message = 'Please enter a valid email'
    } else if (!this.validateService.validatePassword(this.password)) {
      this.message = 'That is not a valid password'
    } else
      {
      const user = {
        email: this.email.toLowerCase(),
        password: this.password
      };

      this.jwtService.login(user).subscribe((resp: any) => {
        if (resp.access_token) {
          // this.message = resp.message;

          // console.log(resp);
          this.jwtService.login(user);
          this.router.navigateByUrl('/books/');
        } else {
          this.message = resp.message;
          this.router.navigateByUrl('/books');
        }
      });
    }

  }
}

import { Component, OnInit } from '@angular/core';
import { ValidateService } from '../../../services/validate.service';
import {Router} from '@angular/router';

import { JwtService } from '../../../jwt.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {
  email: string;
  password: string;

  message: string;


  constructor(
    private jwtService: JwtService,
    private router: Router,
    private validateService: ValidateService) { }

  ngOnInit() {
  }

  register(form) {
    if (!this.validateService.validateEmail(this.email)) {
      this.message = 'Please enter a valid email'
    } else if (!this.validateService.validatePassword(this.password)) {
      this.message = 'That is not a valid password'
    } else {

      const user = {
        email: this.email.toLowerCase(),
        password: this.password
      }

      this.jwtService.register(form.value).subscribe((res) => {
        this.jwtService.login(form.value).subscribe((res) => {
          this.router.navigateByUrl('/');
        });
      });
    }
  }
}

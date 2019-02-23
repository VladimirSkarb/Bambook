import { Component, OnInit } from '@angular/core';
import {Router} from "@angular/router";

import { JwtService } from '../../jwt.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  constructor(private jwtService: JwtService, private router: Router) { }

  ngOnInit() {
  }

  register(form) {
    this.jwtService.register(form.value).subscribe((res) => {
      this.jwtService.login(form.value).subscribe((res)=>{
        this.router.navigateByUrl('/');
      });
    });
  }

}

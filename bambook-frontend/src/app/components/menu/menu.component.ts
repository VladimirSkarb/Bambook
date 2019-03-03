import { Component, OnInit } from '@angular/core';
import {JwtService} from '../../jwt.service';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html',
  styleUrls: ['./menu.component.css']
})
export class MenuComponent implements OnInit {

  constructor(private jwtService: JwtService) { }

  logout() {
    console.log('logout')
    this.jwtService.logout();
  }

  public get loggedIn(): boolean {
    return localStorage.getItem('access_token') !==  null;
  }

  ngOnInit() {
  }

}

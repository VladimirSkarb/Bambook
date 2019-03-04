import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule } from '@angular/common/http';
import { JwtModule } from '@auth0/angular-jwt';
import {HomeComponent} from './components/home/home.component';
import {BooksComponent} from './components/books/books.component';
import {MenuComponent} from './components/menu/menu.component';

@NgModule({
  declarations: [
    AppComponent,
    MenuComponent,
    BooksComponent,
    HomeComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    AppRoutingModule,
    JwtModule.forRoot({
      config: {
        tokenGetter: function  tokenGetter() {
          return     localStorage.getItem('access_token'); },
        whitelistedDomains: ['localhost:3000'],
        blacklistedRoutes: ['http://localhost:3000/api/v1/users/login', 'http://localhost:3000/api/v1/users/register']
      }
    })
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

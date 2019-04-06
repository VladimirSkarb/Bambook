import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { JwtModule } from '@auth0/angular-jwt';
import {HomeComponent} from './components/home/home.component';
import {BooksComponent} from './components/books/books.component';
import {MenuComponent} from './components/menu/menu.component';
import { AddBookComponent } from './components/books/add-book/add-book.component';
import { BookComponent } from './components/books/book/book.component';
import { OfferComponent } from './components/offers/offer/offer.component';
import { AddOfferComponent } from './components/offers/add-offer/add-offer.component';
import { OffersComponent } from './components/offers/offers.component';

@NgModule({
  declarations: [
    AppComponent,
    MenuComponent,
    BooksComponent,
    HomeComponent,
    AddBookComponent,
    BookComponent,
    OfferComponent,
    AddOfferComponent,
    OffersComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    FormsModule,
    AppRoutingModule,
    JwtModule.forRoot({
      config: {
        tokenGetter: function  tokenGetter()  {
          return     localStorage.getItem('access_token'); },
        blacklistedRoutes: ['http://localhost:3000/api/v1/users/login', 'http://localhost:3000/api/v1/users/register']
      }
    })
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

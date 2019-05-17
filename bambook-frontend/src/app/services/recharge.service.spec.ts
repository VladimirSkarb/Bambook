import { TestBed } from '@angular/core/testing';

import { Recharge.ServiceService } from './recharge.service.service';

describe('Recharge.ServiceService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: Recharge.ServiceService = TestBed.get(Recharge.ServiceService);
    expect(service).toBeTruthy();
  });
});

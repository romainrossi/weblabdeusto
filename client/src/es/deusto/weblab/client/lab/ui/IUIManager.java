/*
* Copyright (C) 2005-2009 University of Deusto
* All rights reserved.
*
* This software is licensed as described in the file COPYING, which
* you should have received as part of this distribution.
*
* This software consists of contributions made by many individuals, 
* listed below:
*
* Author: Pablo Orduña <pablo@ordunya.com>
*
*/ 
package es.deusto.weblab.client.lab.ui;

import es.deusto.weblab.client.dto.experiments.ExperimentAllowed;
import es.deusto.weblab.client.dto.experiments.ExperimentID;
import es.deusto.weblab.client.dto.reservations.ConfirmedReservationStatus;
import es.deusto.weblab.client.dto.reservations.WaitingConfirmationReservationStatus;
import es.deusto.weblab.client.dto.reservations.WaitingInstancesReservationStatus;
import es.deusto.weblab.client.dto.reservations.WaitingReservationStatus;
import es.deusto.weblab.client.dto.users.User;
import es.deusto.weblab.client.lab.experiments.exceptions.WlExperimentException;

public interface IUIManager {

	/*
	 * "Happy path" scenario
	 */
	public void onInit();
    public void onLoggedIn(User user);
    public void onAllowedExperimentsRetrieved(ExperimentAllowed[] experimentsAllowed);
    public void onExperimentChosen(ExperimentAllowed experimentAllowed, BoardBase experimentBase);
    public void onWaitingReservation(WaitingReservationStatus reservationStatus);
    public void onWaitingReservationConfirmation(WaitingConfirmationReservationStatus reservationStatus);
    public void onExperimentReserved(ConfirmedReservationStatus reservationStatus, ExperimentID experimentID, BoardBase experimentBase) throws WlExperimentException;
	public void onReservationFinished();
	public void onLoggedOut();
	
	
	/*
	 * Alternative scenarios
	 */
	public void onWrongLoginOrPasswordGiven();
    public void onWaitingInstances(WaitingInstancesReservationStatus reservationStatus);
	
	public void onError(String message);
	public void onErrorAndFinishReservation(String message);
	public void onErrorAndFinishSession(String message);
	public void onMessage(String message);
}

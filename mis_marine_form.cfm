<!-- MIS Marine Contact Form
======================================== -->

    <div class="container">
	
	            <cfif parameterexists(url.contactform)>
		
		
				  <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="##collapseOne">Thanks for your message. We will be in touch!</a>
                </h4>
			<cfelse>
			
			
            
        <form action="marine_form-submit.cfm" id="ais-registration-form">
		<input type=hidden name=type value=AIS>
            <div class="row">
                <div class="col-md-12" id="registration-msg">
                    <p>Fields with an asterisk * are required.</p>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="*First Name" id="fname" name="fname" required>
                    </div>

                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="*Last Name" id="lname" name="lname" required>
                    </div>

                    <div class="form-group">
                        <input type="email" class="form-control" placeholder="*Email" id="email" name="email" required>
                    </div>

                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Phone" id="phone" name="phone">
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Company" id="company" name="company">
                    </div>
                </div>


                <div class="col-sm-6">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Facility" id="facility" name="facility">
                    </div>

                    <div class="form-group">
                        <select class="form-control" name="state" id="state">
                            <option readonly>Select State</option>
                            <option value="AL">Alabama</option>
                            <option value="AK">Alaska</option>
                            <option value="AZ">Arizona</option>
                            <option value="AR">Arkansas</option>
                            <option value="CA">California</option>
                            <option value="CO">Colorado</option>
                            <option value="CT">Connecticut</option>
                            <option value="DE">Delaware</option>
                            <option value="DC">District Of Columbia</option>
                            <option value="FL">Florida</option>
                            <option value="GA">Georgia</option>
                            <option value="HI">Hawaii</option>
                            <option value="ID">Idaho</option>
                            <option value="IL">Illinois</option>
                            <option value="IN">Indiana</option>
                            <option value="IA">Iowa</option>
                            <option value="KS">Kansas</option>
                            <option value="KY">Kentucky</option>
                            <option value="LA">Louisiana</option>
                            <option value="ME">Maine</option>
                            <option value="MD">Maryland</option>
                            <option value="MA">Massachusetts</option>
                            <option value="MI">Michigan</option>
                            <option value="MN">Minnesota</option>
                            <option value="MS">Mississippi</option>
                            <option value="MO">Missouri</option>
                            <option value="MT">Montana</option>
                            <option value="NE">Nebraska</option>
                            <option value="NV">Nevada</option>
                            <option value="NH">New Hampshire</option>
                            <option value="NJ">New Jersey</option>
                            <option value="NM">New Mexico</option>
                            <option value="NY">New York</option>
                            <option value="NC">North Carolina</option>
                            <option value="ND">North Dakota</option>
                            <option value="OH">Ohio</option>
                            <option value="OK">Oklahoma</option>
                            <option value="OR">Oregon</option>
                            <option value="PA">Pennsylvania</option>
                            <option value="RI">Rhode Island</option>
                            <option value="SC">South Carolina</option>
                            <option value="SD">South Dakota</option>
                            <option value="TN">Tennessee</option>
                            <option value="TX">Texas</option>
                            <option value="UT">Utah</option>
                            <option value="VT">Vermont</option>
                            <option value="VA">Virginia</option>
                            <option value="WA">Washington</option>
                            <option value="WV">West Virginia</option>
                            <option value="WI">Wisconsin</option>
                            <option value="WY">Wyoming</option>
                           	<option readonly>-------- Territories ----------</option>
                            <option value="AS">American Samoa</option>
                            <option value="GU">Guam</option>
                            <option value="MP">Northern Mariana Islands</option>
                            <option value="PR">Puerto Rico</option>
                            <option value="UM">United States Minor Outlying Islands</option>
                            <option value="VI">Virgin Islands</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <select class="form-control" name="reason" id="reason">
                            <option readonly>Reason for Inquiry</option>
                            <option>- Tracking Host Program</option>
                            <option>- Tracking Subscription</option>
                            <option>- MIS Company Information</option>
                            <option>- Press Inquiry</option>
                            <option>- General Inquiry</option>
                        </select>
                    </div>
                    
                   <div class="form-group">
                        <textarea class="form-control" placeholder="Comments" id="comments" name="comments"></textarea>
                    </div>


                    
                    
                </div>
            </div>
            <div class="text-center mt20">
                <button type="submit" class="btn btn-black" id="contact-submit-btn">Submit</button>
            </div>
        </form>
    </div>
</cfif>


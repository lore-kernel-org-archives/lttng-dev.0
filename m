From: Aaron Spear <aspear-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [lttng-dev] Java code for CTF trace writing?
Date: Tue, 23 Apr 2013 11:21:37 -0700 (PDT)
Message-ID: <1962635283.7490228.1366741297558.JavaMail.root@vmware.com>
References: <CAB4xu_1zOHUD03dQ57DxKpQ1RWorocGK_0URCaxnohHB1FLEDw@mail.gmail.com>
	<5176AAFA.8060905@ericsson.com>
Reply-To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
In-Reply-To: <5176AAFA.8060905-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://dev.eclipse.org/mailman/options/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://dev.eclipse.org/mailman/private/linuxtools-dev>
List-Post: <mailto:linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://dev.eclipse.org/mailman/listinfo/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
Sender: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
To: Matthew Khouzam <matthew.khouzam-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Philippe Proulx <philippe.proulx-scC8bbJcJLCw5LPnMra/2Q@public.gmane.org>, lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org, Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org



----- Original Message -----
> Hi all,
> Just to mention, everything Philippe said was 100% true, we just right
> now are too stretched to add the trace writer to eclipse. It will be
> integrated fairly soon, I think.
> Matt

Hi Matthew,

Sounds very good, do you have a ball park estimate when "fairly soon" is?  

Also, who is planning to do the work?  I would be happy to assist if I can.  

As I at least implied, I am happy to collaborate on this.  Right now my prototype is writing out events to a text log file, which is vastly less than ideal.  In short order I am going to need to be able to do two things:

1) write CTF traces from Java code
2) be able to append to this trace dynamically while it is being analyzed.  Ideally the view registers a listener with the model and perhaps also specifying some hysteresis (so it is notified on a block of events, not every event), and then when it is notified it can update (optionally subject to an "update policy" selected in the view, as is often done with debugging)

cheers,
Aaron

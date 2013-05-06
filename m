From: Aaron Spear <aspear-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: Java code for CTF trace writing?
Date: Mon, 6 May 2013 10:53:27 -0700 (PDT)
Message-ID: <1670315418.908522.1367862807840.JavaMail.root@vmware.com>
References: <CAB4xu_1zOHUD03dQ57DxKpQ1RWorocGK_0URCaxnohHB1FLEDw@mail.gmail.com>
	<5176AAFA.8060905@ericsson.com>
	<1962635283.7490228.1366741297558.JavaMail.root@vmware.com>
	<5176D556.8040801@ericsson.com>
	<1218416875.7614701.1366750233878.JavaMail.root@vmware.com>
	<A94B468263DDE2448A14367F590EB97301D4DA41@ltcfiswmsgmb15>
Reply-To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
In-Reply-To: <A94B468263DDE2448A14367F590EB97301D4DA41@ltcfiswmsgmb15>
List-Unsubscribe: <https://dev.eclipse.org/mailman/options/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://dev.eclipse.org/mailman/private/linuxtools-dev>
List-Post: <mailto:linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://dev.eclipse.org/mailman/listinfo/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
Sender: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
To: Erik Ostermueller <Erik.Ostermueller-/Lv4ykeZ0xsS+FvcfC7Uqw@public.gmane.org>
Cc: Philippe Proulx <philippe.proulx-scC8bbJcJLCw5LPnMra/2Q@public.gmane.org>, Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>, lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org
List-Id: lttng-dev@lists.lttng.org

Hi Erik,

The answer at this moment is no, you can't see that.  That said, that is certainly the vision of what I want to create.  I am working on extending a view so that I can see Java methods in one trace alongside state changes that come from another trace. The idea is to have a single view that knows how to present state vs. time and then providers for that state for different kinds of tracing.  I have in fact done exactly what you want (java app trace + linux kernel trace), but it is clunky right now because you cannot see the Linux kernel trace and the Java trace at the same time.

The issue here is simply one of implementation choices related to how traces are viewed.  At this moment the views in the LTTng viewer are singletons setup to only allow one trace to be viewed at a time (mostly.  the "Time Chart" view is an exception to this). What is needed is one of two things (I think both):

1) support for being able to open as many instances of views as you wish, and then "pin" them to a particular trace.  If you could do this then you could open an LTTng linux kernel view and a java trace and whatever else you wanted at the same time. In addition to the pin support the views would need some mechanism for time sync between them (like the current control flow view syncs based on the selection in Histogram view)

2) Change the "state flow view" that I created (borrowing code from the control flow view) so it supports multiple traces (e.g. LTTng kernel trace).  I am working on this right now for data driven traces.  One thought is that this view infrastructure could be changed so that a single view could show all of these different types of traces.  A bunch of refactoring would be required to do this though.  The current ControlFlowView has things very specific to kernel traces that don't make sense generically (e.g. process related details as columns in the trace)

I can't comment as to the official direction of the project (since I am not a committer...) but Perhaps Alexandre or others could comment on thoughts on what could be done to address this and when.

regards, 
Aaron Spear



----- Original Message -----
> Hello all,
> 
> I've got a question about the Java code that writes CTF traces.
> Would this design provide a single trace with Java events and OS events in
> the same trace?
> Here is an example:
> 
> Consider an all-Java program that sends an XML requests request over HTTP.
> Would like the trace detail to show Java method activity as well as OS
> activity that opens/closes the socket.
> 
> This could be very helpful for unveiling the details of how Java code
> consumes hardware resources.
> 
> Thanks,
> --Erik
> 
> -----Original Message-----
> From: Aaron Spear [mailto:aspear-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org]
> Sent: Tuesday, April 23, 2013 3:51 PM
> To: Matthew Khouzam
> Cc: Philippe Proulx; Dominique Toupin; lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org; Linux Tools
> developer discussions
> Subject: Re: [lttng-dev] Java code for CTF trace writing?
> 
> > When would you be available to work on this feature, I would love to
> > sync up our efforts for this.
> 
> The way things look right now, I will have bandwidth for it in another month,
> so middle to end of May. Perhaps sooner if all the stars align.
> 
> Aaron
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> _____________
> The information contained in this message is proprietary and/or confidential.
> If you are not the intended recipient, please: (i) delete the message and
> all copies; (ii) do not disclose, distribute or use the message in any
> manner; and (iii) notify the sender immediately. In addition, please be
> aware that any message addressed to our domain is subject to archiving and
> review by persons other than the intended recipient. Thank you
> 

From: Bernd Hufmann <bernd.hufmann-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: Java code for CTF trace writing?
Date: Thu, 9 May 2013 11:05:34 +0000
Message-ID: <1EE6FD30D622B345AF385887190055E3086F41@eusaamb107.ericsson.se>
References: <CAB4xu_1zOHUD03dQ57DxKpQ1RWorocGK_0URCaxnohHB1FLEDw@mail.gmail.com>
	<5176AAFA.8060905@ericsson.com>
	<1962635283.7490228.1366741297558.JavaMail.root@vmware.com>
	<5176D556.8040801@ericsson.com>
	<1218416875.7614701.1366750233878.JavaMail.root@vmware.com>
	<A94B468263DDE2448A14367F590EB97301D4DA41@ltcfiswmsgmb15>
	<1670315418.908522.1367862807840.JavaMail.root@vmware.com>
	<1EE6FD30D622B345AF385887190055E3085C45@eusaamb107.ericsson.se>,
	<1100886.2797960.1368024815323.JavaMail.root@vmware.com>
Reply-To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
In-Reply-To: <1100886.2797960.1368024815323.JavaMail.root-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Content-Language: en-CA
List-Unsubscribe: <https://dev.eclipse.org/mailman/options/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://dev.eclipse.org/mailman/private/linuxtools-dev>
List-Post: <mailto:linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://dev.eclipse.org/mailman/listinfo/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
Sender: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
To: Aaron Spear <aspear-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Cc: Philippe Proulx <philippe.proulx-scC8bbJcJLCw5LPnMra/2Q@public.gmane.org>, "lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org" <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

Hi Aaron,

Some more comments below.

Best Regards
Bernd
________________________________________
From: Aaron Spear [aspear-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org]
Sent: May 8, 2013 10:53 AM
To: Bernd Hufmann
Cc: Erik Ostermueller; Philippe Proulx; Dominique Toupin; Linux Tools developer discussions; lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org
Subject: Re: Java code for CTF trace writing?

Hi Bernd,

Thanks much for the insightful comments.  Some more thoughts injected below:

----- Original Message -----
> > Hi Aaron
> >
> > I'd like to comment on the pinning of views (the rest of the discussion is
> > already covered by Alexandre).
> >
> > > 1) support for being able to open as many instances of views as you wish,
> > > and then "pin" them to a particular trace.  If you could do this then you
> > > could open an LTTng linux kernel view and a java trace and
> > > whatever else you wanted at the same time. In addition to the pin support
> > > the views would need some mechanism for time sync between them (like the
> > > current control flow view syncs based on the selection in
> > > Histogram view)
> >
> > Since Eclipse supports to have multiple instances of the same view it should
> > be straight forward to support multiple instances of the Tracing views. To
> > do that we need to provide an unique instance ID to distinguish the
> > different views. The data handled in the view has to be specific to the
> > instance of the view. For our purpose, the data to be displayed will be
> > related to the trace implementation (ITmfTrace). We have to make sure that
> > the data and view are separated properly (data encapsulation). The next
> > question is how to open a new instance of a tracing view (e.g.
> > ControlFlowView). We could implement it similarly to the Eclipse Properties
> > view. This means we have pin button and command to pin the view to the
> > current active trace. To not change content when changing the trace, the
> > pinned view has to ignore all relevant signals sent between views (e.g.
> > TmfTraceSelectedSignal, TmfTraceOpenedSignal). Additionally, the views need
> > a "Clone" or "New Instance" command (e.g. in the view menu) that creates a
> > new instance of the view. The new view will be filled with the current
> > active trace information (or stays empty initially) and when changing the
> > trace the cloned view will change the content with the new trace
> > information.
> >
> > For the time synchronisation between views, we could have multiple instances
> > of the Histogram View, each one synchronises with the corresponding tracing
> > view instances from above. Or maybe the TimeChartView is sufficient to
> > handle the time synchronisation.
> >
> > Would it be beneficial to have a global action that would allow the user to
> > clone multiple tracing views at the time? This action could allow the user
> > to select the views to be cloned. This could be handy if there are multiple
> > views that need to be cloned at the same time.
> 
> One thing that I think is important to keep in mind is that in the average users mind, they will probably not think much about the editor-view model like it is in the Eclipse sense, meaning that for them the control flow, or whatever other view they are looking primarily that shows 
> behavior vs. time is in their mind "the trace" as opposed to the tabular editor with all the raw trace events in it.  I mention it only because whatever it is that we do, it seems to me that it would be nice if the usage of it was fluid and natural.  I could see wanting to a new control flow 
> instance open every time that I open another trace (or having the same view simply add the additional trace content).  So all that to say, I don't think cloning a view, switching to a different trace, and then pinning is the only way that we want to have it work.  I think that it would be 
> sensible to have a preference that created a mode whereby any time that you opened a new trace, a separate instance of the views opened, and those separate instances were setup to listen for "shared time navigation signals" which control what time range and particular time is 
> selected globally.
I agree, that for all the changes we have to keep usability in mind and it should be as intuitive and easy as possible for the user. The preference idea could be a way to go. We could have a default behaviour, where all views are shared across traces (as it is today). The other behaviour (advanced behaviour ?) could be that a new instance of the tracing views is opened when opening a trace. However, for the second behaviour I think it would be beneficial to select the set of view to be opened. We don't want to open views the user is not interested in and having to close them manually.

> 
> Also regarding the current histogram view, this view is really nice in the way that it functions and controls time in the control flow and other views, but I do think it is a screen real estate hog.  I don't think that having multiple instances of this is a good idea.  I have multiple 27 inch 
> monitors, and in my current usage I struggle for space.  So, I cannot help but wonder if there could be another incarnation of it that is more like a combination of the time chart view and the histogram view.  In this updated time navigator, you could define synchronization groups for 
> traces (and have a single global group by default) where for a given group there is a single range selection, and all trace views sync to this range.  It also seems to me that this sort of presentation might also make sense to be the place where you can adjust the time offset/bias on 
> traces manually, or you could have access to plugins that process multiple traces and then do smart time adjustment based on network or other events expressed in CTF to indicate relationships between traces (such as is being discussed in this thread)

Yeah, screen real estate is a problem. Especially with the addition of more analysis views. I think we need to define proper preferences to be able to group views and define their behaviour (i.e. open new instance every time a trace opens, time synchronization across views).  

> 
>
> By the way, the base view class TmfView has already an action to pin a view
> that extends TmfView. Once created it will add a pin button (toggle) to the
> view's toolbar. This action toggles a flag in the base class and all
> sub-class can query this information and act accordingly. Initially this pin
> action was intended to be used to pin a view for the current selected time
> and time range. It hasn't been used by any of the Open Souce Tracing views.
> Even if it was meant for pinning to the current time, it's free for use and
> could be also be used for pinning to the current trace.

> Sounds like a start.  Seems like having a shared facility on each view so that it can change the trace that it is pinned to and then its update/synchronization behavior would be good.  e.g. a radio button selection/list of the "sync groups" that are available.  If you select one, then any 
> time events are fired to change the selection/range for that group then the view updates.  Otherwise it does not.  Will will likely also need update policies on how fast to update and such in the future when doing live traces.

Again here, we have to define preferences and manage them properly in a central way so that each view can access them and adjust it's behaviour.

>
> Best Regards
> Bernd
>
> ________________________________________
> From: Aaron Spear [aspear-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org]
> Sent: May 6, 2013 1:53 PM
> To: Erik Ostermueller
> Cc: Philippe Proulx; Dominique Toupin; Linux Tools developer discussions;
> lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org
> Subject: Re: [lttng-dev] Java code for CTF trace writing?
>
> Hi Erik,
>
> The answer at this moment is no, you can't see that.  That said, that is
> certainly the vision of what I want to create.  I am working on extending a
> view so that I can see Java methods in one trace alongside state changes
> that come from another trace. The idea is to have a single view that knows
> how to present state vs. time and then providers for that state for
> different kinds of tracing.  I have in fact done exactly what you want (java
> app trace + linux kernel trace), but it is clunky right now because you
> cannot see the Linux kernel trace and the Java trace at the same time.
>
> The issue here is simply one of implementation choices related to how traces
> are viewed.  At this moment the views in the LTTng viewer are singletons
> setup to only allow one trace to be viewed at a time (mostly.  the "Time
> Chart" view is an exception to this). What is needed is one of two things (I
> think both):
>
> 1) support for being able to open as many instances of views as you wish, and
> then "pin" them to a particular trace.  If you could do this then you could
> open an LTTng linux kernel view and a java trace and whatever else you
> wanted at the same time. In addition to the pin support the views would need
> some mechanism for time sync between them (like the current control flow
> view syncs based on the selection in Histogram view)
>
> 2) Change the "state flow view" that I created (borrowing code from the
> control flow view) so it supports multiple traces (e.g. LTTng kernel trace).
> I am working on this right now for data driven traces.  One thought is that
> this view infrastructure could be changed so that a single view could show
> all of these different types of traces.  A bunch of refactoring would be
> required to do this though.  The current ControlFlowView has things very
> specific to kernel traces that don't make sense generically (e.g. process
> related details as columns in the trace)
>
> I can't comment as to the official direction of the project (since I am not a
> committer...) but Perhaps Alexandre or others could comment on thoughts on
> what could be done to address this and when.
>
> regards,
> Aaron Spear
>
>
>
> ----- Original Message -----
> > Hello all,
> >
> > I've got a question about the Java code that writes CTF traces.
> > Would this design provide a single trace with Java events and OS events in
> > the same trace?
> > Here is an example:
> >
> > Consider an all-Java program that sends an XML requests request over HTTP.
> > Would like the trace detail to show Java method activity as well as OS
> > activity that opens/closes the socket.
> >
> > This could be very helpful for unveiling the details of how Java code
> > consumes hardware resources.
> >
> > Thanks,
> > --Erik
> >
> > -----Original Message-----
> > From: Aaron Spear [mailto:aspear-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org]
> > Sent: Tuesday, April 23, 2013 3:51 PM
> > To: Matthew Khouzam
> > Cc: Philippe Proulx; Dominique Toupin; lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org; Linux
> > Tools
> > developer discussions
> > Subject: Re: [lttng-dev] Java code for CTF trace writing?
> >
> > > When would you be available to work on this feature, I would love to
> > > sync up our efforts for this.
> >
> > The way things look right now, I will have bandwidth for it in another
> > month,
> > so middle to end of May. Perhaps sooner if all the stars align.
> >
> > Aaron
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> > _____________
> > The information contained in this message is proprietary and/or
> > confidential.
> > If you are not the intended recipient, please: (i) delete the message and
> > all copies; (ii) do not disclose, distribute or use the message in any
> > manner; and (iii) notify the sender immediately. In addition, please be
> > aware that any message addressed to our domain is subject to archiving and
> > review by persons other than the intended recipient. Thank you
> >
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

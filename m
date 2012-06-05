From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: Re: Displaying graphical results
Date: Tue, 5 Jun 2012 09:40:53 -0400
Message-ID: <4FCE0C65.7010906__41305.2709227943$1338903700$gmane$org@ericsson.com>
References: <CABnnsm_MJHGq_TcjZj5_4_2TmTDhQUPGeJAyd3HYn6V7bPFQaw@mail.gmail.com>
	<524C960C5DFC794E82BE548D825F05CF283435F8@EU-MBX-01.mgc.mentorg.com>
	<CABnnsm8x2PJi93O=yu49-LZ8D2WMZwCr2PZQGb5zL97SeKQdxg@mail.gmail.com>
	<CABnnsm8mTJ4XGgV3XqJ-Qbp1QXOuGevrqL=7rgmPou-83pZ7tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0268050369=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr3.ericy.com ([198.24.6.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1Sbu0O-0000fF-I3
	for lttng-dev@lists.lttng.org; Tue, 05 Jun 2012 09:41:04 -0400
In-Reply-To: <CABnnsm8mTJ4XGgV3XqJ-Qbp1QXOuGevrqL=7rgmPou-83pZ7tQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: tchak adim <montarcyber@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0268050369==
Content-Type: multipart/alternative;
	boundary="------------040805030908030107060203"

--------------040805030908030107060203
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by imr3.ericy.com id q55Det8U018491

Hi

We are currently finalizing the LTTng 2.0 Integration in Eclipse as part=20
of the Eclipse Juno release.

As I understood you are using the source code of Eclipse LTTng 2.0=20
integration. After starting the Eclipse application, switch to the=20
perspective "LTTng Kernel". By default the following views will show:

  * Project Explorer
    This view is for handling Tracing projects, traces and experiments.
    To start viewing a trace, use the New Project wizard of Eclipse to
    create "Tracing Project".  (Right mouse click in Project Explorer
    view -> New - Tracing Project). Then import a trace to the "Traces"
    sub-folder of you newly created project. (Right mouse click on
    folder "Traces"). You could also drag-&-drop a trace to the "Traces"
    sub-folder. Note that you need to select the the trace type during
    import (not drag&drop) or afterwards by using the context-sensitive
    menu on the trace (Right mouse-click on the trace -> Click on
    "Select Trace Type..." -> Common Trace Format -> Kernel Trace).
    After that you can open the trace.
  * Control
    This view is to create traces remotely using an SSH connection to a
    remote (or local) host. This if you want to create a session,
    enable/disable events or channels, start and stop tracing. You also
    can import create trace to your workspace
  * Events View
    This view contains a table displaying each event in a table form.
     From the top row you can search or filter events
  * Control Flow View
    This view shows the kernel control flow (process states over time).
    It uses internally a persistent state system which is create when
    you open the trace the first time. In this view you can zoom using
    cool bar buttons or mouse wheel. You can step from one event to the
    next/previous event per process using the relevant buttons.
  * Resources View
    This view shows you system resources such as CPUs, IRQs, Soft IRQs
    and their states over time. This view also uses the persistent state
    system I mentioned above. The buttons, zooming behaviour etc. are
    same as for the Control Flow View
  * Histogram View
    This view shows the event density (number of events over time). The
    big window shows the whole trace. The same one shows the current
    selected time range.
  * Statistics View
    This view shows you the total number events and number of events per
    event time of the whole trace
  * Bookmarks view
    Using the context-sensitive menu of the Events table you can
    bookmark events. In the bookmark view you can double-click on a
    bookmark and the event will be shown in the events table as well as
    in all other open LTTng views.

All views are synchronized. That means when selecting an event one of=20
the view, it will  be shown also in the other views. Additionally, when=20
changing the active time range (e.g. in the Histogram View), also the=20
Control Flow View/Resources View will show the new time range.

This was a brief introduction into what is coming up for the LTTng Juno.=20
Keep in mind, that there might be still some bugs, so I apologizes for=20
any glitches you may experience. These glitches will be fixed, as well=20
as a comprehensive User Guide will be available for the Juno release.

Best Regards
Bernd

On 06/05/2012 05:27 AM, Francis Giraldeau wrote:
> Le 2012-06-04 22:57, tchak adim a =E9crit :
>> for Eclipse tool :
>> i already follow the different steps to integrate the cft, lttng2
>> plugins as described in the link that u give it .
>> i don't konw how can i visualize the graphics of lttng kernel module
>> traces using eclipse , can u explain to me how ?
> You need to select the lttng perspective, then create an lttng project,
> import a trace trace and then it should show up. There are multiple
> views, the event view displays events in a table, and the control flow
> view shows process states according to time.
>
> Cheers,
>
> Francis
>



On 06/04/2012 04:57 PM, tchak adim wrote:
> for Eclipse tool :
> i already follow the different steps to integrate the cft, lttng2=20
> plugins as described in the link that u give it .
> i don't konw how can i visualize the graphics of lttng kernel module=20
> traces using eclipse , can u explain to me how ?
>
> For sourcery tool :
> i didn't find the source code, i'm using an ordinary i386 machine=20
> running ubuntu 10.04.
>
> Can u advice me and tell me what i can do ?
>
> thanks in advance !


--------------040805030908030107060203
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi<br>
    <br>
    We are currently finalizing the LTTng 2.0 Integration in Eclipse as
    part of the Eclipse Juno release. <br>
    <br>
    As I understood you are using the source code of Eclipse LTTng 2.0
    integration. After starting the Eclipse application, switch to the
    perspective "LTTng Kernel". By default the following views will
    show:<br>
    <ul>
      <li>Project Explorer<br>
        This view is for handling Tracing projects, traces and
        experiments. To start viewing a trace, use the New Project
        wizard of Eclipse to create "Tracing Project".&nbsp; (Right mouse
        click in Project Explorer view -&gt; New - Tracing Project).
        Then import a trace to the "Traces" sub-folder of you newly
        created project. (Right mouse click on folder "Traces"). You
        could also drag-&amp;-drop a trace to the "Traces" sub-folder.
        Note that you need to select the the trace type during import
        (not drag&amp;drop) or afterwards by using the context-sensitive
        menu on the trace (Right mouse-click on the trace -&gt; Click on
        "Select Trace Type..." -&gt; Common Trace Format -&gt; Kernel
        Trace). After that you can open the trace.<br>
      </li>
      <li>Control<br>
        This view is to create traces remotely using an SSH connection
        to a remote (or local) host. This if you want to create a
        session, enable/disable events or channels, start and stop
        tracing. You also can import create trace to your workspace</li>
      <li>Events View<br>
        This view contains a table displaying each event in a table
        form. From the top row you can search or filter events</li>
      <li>Control Flow View<br>
        This view shows the kernel control flow (process states over
        time). It uses internally a persistent state system which is
        create when you open the trace the first time. In this view you
        can zoom using cool bar buttons or mouse wheel. You can step
        from one event to the next/previous event per process using the
        relevant buttons.<br>
      </li>
      <li>Resources View<br>
        This view shows you system resources such as CPUs, IRQs, Soft
        IRQs and their states over time. This view also uses the
        persistent state system I mentioned above. The buttons, zooming
        behaviour etc. are same as for the Control Flow View</li>
      <li>Histogram View<br>
        This view shows the event density (number of events over time).
        The big window shows the whole trace. The same one shows the
        current selected time range.</li>
      <li>Statistics View<br>
        This view shows you the total number events and number of events
        per event time of the whole trace<br>
      </li>
      <li>Bookmarks view<br>
        Using the context-sensitive menu of the Events table you can
        bookmark events. In the bookmark view you can double-click on a
        bookmark and the event will be shown in the events table as well
        as in all other open LTTng views.</li>
    </ul>
    <p>All views are synchronized. That means when selecting an event
      one of the view, it will&nbsp; be shown also in the other views.
      Additionally, when changing the active time range (e.g. in the
      Histogram View), also the Control Flow View/Resources View will
      show the new time range.<br>
    </p>
    <p>This was a brief introduction into what is coming up for the
      LTTng Juno. Keep in mind, that there might be still some bugs, so
      I apologizes for any glitches you may experience. These glitches
      will be fixed, as well as a comprehensive User Guide will be
      available for the Juno release. <br>
    </p>
    Best Regards<br>
    Bernd<br>
    <br>
    On 06/05/2012 05:27 AM, Francis Giraldeau wrote:
    <blockquote cite="mid:4FCDD0F2.9020009@gmail.com" type="cite">
      <pre wrap="">Le 2012-06-04 22:57, tchak adim a &eacute;crit :
</pre>
      <blockquote type="cite">
        <pre wrap="">for Eclipse tool :
i already follow the different steps to integrate the cft, lttng2
plugins as described in the link that u give it .
i don't konw how can i visualize the graphics of lttng kernel module
traces using eclipse , can u explain to me how ?
</pre>
      </blockquote>
      <pre wrap="">You need to select the lttng perspective, then create an lttng project,
import a trace trace and then it should show up. There are multiple
views, the event view displays events in a table, and the control flow
view shows process states according to time.

Cheers,

Francis

</pre>
    </blockquote>
    <br>
    <br>
    <br>
    On 06/04/2012 04:57 PM, tchak adim wrote:
    <blockquote
cite="mid:CABnnsm8mTJ4XGgV3XqJ-Qbp1QXOuGevrqL=7rgmPou-83pZ7tQ@mail.gmail.com"
      type="cite">for Eclipse tool :<br>
      i already follow the different steps to integrate the cft, lttng2
      plugins as described in the link that u give it .<br>
      i don't konw how can i visualize the graphics of lttng kernel
      module traces using eclipse , can u explain to me how ?<br>
      <br>
      For sourcery tool :<br>
      i didn't find the source code, i'm using an ordinary i386 machine
      running ubuntu 10.04. <br>
      <br>
      Can u advice me and tell me what i can do ?<br>
      <br>
      thanks in advance !<br>
    </blockquote>
    <br>
  </body>
</html>

--------------040805030908030107060203--


--===============0268050369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0268050369==--

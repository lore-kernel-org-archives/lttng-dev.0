From: John O'Sullivan <John.OSullivan@BlackBox.com>
Subject: Correct way to use the tpl file
Date: Fri, 30 Nov 2018 16:09:00 +0000
Message-ID: <1543594140321.1890__41946.5031977326$1543594105$gmane$org@BlackBox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5978243327597148004=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from esa1.hc2026-0.iphmx.com (esa1.hc2026-0.iphmx.com
 [68.232.147.122])
 by lists.lttng.org (Postfix) with ESMTPS id 435zr53lcYzwS7
 for <lttng-dev@lists.lttng.org>; Fri, 30 Nov 2018 11:10:13 -0500 (EST)
Content-Language: en-IE
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5978243327597148004==
Content-Language: en-IE
Content-Type: multipart/alternative;
	boundary="_000_15435941403211890BlackBoxcom_"

--_000_15435941403211890BlackBoxcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I am looking for some advice on the best way to manage the tracing of some =
user space events.


I have a series of events that are fed to queues, they look something like =
the following sample



EventEnd* event_end_new()
{
    EventEnd* event_end =3D bb_xnew(EventEnd,__func__);

    if (event_end !=3D NULL)
    {
        event_end->type =3D EQ_EVENT_END;
    .   .. other event specific fields here

        ..
    }
#ifdef LTTNG_TRACE
    tracepoint(core_event_trace, end_event_tracepoint, EQ_EVENT_END);
#endif
    return event_end;
}




I want to try and trace these so created the following template shown below=
. My question is, does the class have to have all of the possible members t=
hat the different instances will have, as each unique event is likely to ha=
ve different members will the class have to have all of these members defin=
es, and if this is the case is it okay for an instance to just implement a =
subset of the members the class defines?





TRACEPOINT_EVENT_CLASS(
    /* Tracepoint provider name */
    core_event_trace,

    /* Tracepoint class name */
    core_event_tracepoint_class,

/* Input arguments */
    TP_ARGS(
      int, event_type

    ),

    /* Output event fields */
    TP_FIELDS(
        ctf_integer(int, event_type, event_type)

    )
)





TRACEPOINT_EVENT_INSTANCE(
    core_event_trace,
    core_event_tracepoint_class,
    end_event_tracepoint,
    TP_ARGS(
      int, event_type

    )
)

TRACEPOINT_EVENT_INSTANCE(
    core_event_trace,
    core_event_tracepoint_class,
    start_event_tracepoint,
    TP_ARGS(
      int, event_type
    )
)



TRACEPOINT_EVENT_INSTANCE(
    core_event_trace,
    core_event_tracepoint_class,
    foo_event_tracepoint,
    TP_ARGS(
      int, event_type
    )
)

________________________________

This email and any files transmitted with it are confidential and are inten=
ded for the sole use of the individual to whom they are addressed. Black Bo=
x Corporation reserves the right to scan all e-mail traffic for restricted =
content and to monitor all e-mail in general. If you are not the intended r=
ecipient or you have received this email in error, any use, dissemination o=
r forwarding of this email is strictly prohibited. If you have received thi=
s email in error, please notify the sender by replying to this email.

--_000_15435941403211890BlackBoxcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} --></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi,</p>
<p>I am looking for some advice on the best way to manage the tracing of so=
me user space events.</p>
<p><br>
</p>
<p>I have a series of events that are fed to queues, they look something li=
ke the following sample<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p>EventEnd* event_end_new()<br>
{<br>
&nbsp;&nbsp; &nbsp;EventEnd* event_end =3D bb_xnew(EventEnd,__func__);<br>
<br>
&nbsp;&nbsp; &nbsp;if (event_end !=3D NULL)<br>
&nbsp;&nbsp; &nbsp;{<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;event_end-&gt;type =3D EQ_EVENT_END;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;. &nbsp; .. other event specific fields here</p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; ..<br>
&nbsp;&nbsp; &nbsp;}<br>
#ifdef LTTNG_TRACE<br>
&nbsp;&nbsp; &nbsp;tracepoint(core_event_trace, end_event_tracepoint, EQ_EV=
ENT_END);<br>
#endif<br>
&nbsp;&nbsp; &nbsp;return event_end;<br>
}<br>
</p>
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
<p>I want to try and trace these so created the following template shown be=
low. My question is, does the class have to have all of the possible member=
s that the different instances will have, as each unique event is likely to=
 have different members will the
 class have to have all of these members defines, and if this is the case i=
s it okay for an instance to just implement a subset of the members the cla=
ss defines?</p>
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
<p><br>
</p>
<p>TRACEPOINT_EVENT_CLASS(<br>
&nbsp;&nbsp;&nbsp; /* Tracepoint provider name */<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
<br>
&nbsp;&nbsp;&nbsp; /* Tracepoint class name */<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
<br>
/* Input arguments */<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br>
<br>
&nbsp;&nbsp;&nbsp; ),<br>
<br>
&nbsp;&nbsp;&nbsp; /* Output event fields */<br>
&nbsp;&nbsp;&nbsp; TP_FIELDS(<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; ctf_integer(int, event_type, event_ty=
pe)<br>
<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br>
<br>
<br>
<br>
<br>
<br>
TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; end_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br>
<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br>
<br>
TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; start_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br>
<br>
<br>
<br>
TRACEPOINT_EVENT_INSTANCE(<br>
&nbsp;&nbsp;&nbsp; core_event_trace,<br>
&nbsp;&nbsp;&nbsp; core_event_tracepoint_class,<br>
&nbsp;&nbsp;&nbsp; foo_event_tracepoint,<br>
&nbsp;&nbsp;&nbsp; TP_ARGS(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int, event_type<br>
&nbsp;&nbsp;&nbsp; )<br>
)<br>
</p>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1"><br>
This email and any files transmitted with it are confidential and are inten=
ded for the sole use of the individual to whom they are addressed. Black Bo=
x Corporation reserves the right to scan all e-mail traffic for restricted =
content and to monitor all e-mail
 in general. If you are not the intended recipient or you have received thi=
s email in error, any use, dissemination or forwarding of this email is str=
ictly prohibited. If you have received this email in error, please notify t=
he sender by replying to this email.<br>
</font>
</body>
</html>

--_000_15435941403211890BlackBoxcom_--

--===============5978243327597148004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5978243327597148004==--

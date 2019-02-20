From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Tracepoints firing without being enabled in LTTng
Date: Wed, 20 Feb 2019 09:46:57 -0500 (EST)
Message-ID: <1429830431.1895.1550674017298.JavaMail.zimbra__28656.8430646852$1550674044$gmane$org@efficios.com>
References: <CAJyWpKEMbN8RHuGbODZYFiOff_pN08Zn4A=6dMEEe7C7h3nn1g@mail.gmail.com>
 <CAJyWpKH2TWmCXhvtSaE-h+jKfmt8aKQ0MaYOr_TqQ0q+M1f_gw@mail.gmail.com>
 <CADcCL0hnLNyzOvfpBRW=TzDR9Ekckei5NGOqpAQ=rMUpGnRLEQ@mail.gmail.com>
 <CAJyWpKEgHDa2gPte2eTVg9UCo6RBOBKfPLg9XFUyVcVxMoj8tA@mail.gmail.com>
 <CADcCL0gt=kQop0miSLD3edcKLNERgg+XEjmgkvzdX=A4t_MzuQ@mail.gmail.com>
 <CAJyWpKGEC5dXZXWTupdJA6BVUQhzp5dT-jDX6iX_EE=JrvU4KA@mail.gmail.com>
 <CADcCL0ieGaTA4_=rxaLT2=LAuhQdJGfjM7HYg34eTo-Oo_JDYg@mail.gmail.com>
 <CAJyWpKG2mJJ-DnHLr1gRhrPw5Qsj=TT0j_5FCaQKv7t0qkqcdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6006033575858441240=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 444L6K3nX8zgC3
 for <lttng-dev@lists.lttng.org>; Wed, 20 Feb 2019 09:47:05 -0500 (EST)
In-Reply-To: <CAJyWpKG2mJJ-DnHLr1gRhrPw5Qsj=TT0j_5FCaQKv7t0qkqcdA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mosleh Uddin <mosleh1235@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6006033575858441240==
Content-Type: multipart/alternative;
	boundary="=_26d154aa-14be-41b2-9f66-5dfa1966c5ff"

--=_26d154aa-14be-41b2-9f66-5dfa1966c5ff
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Feb 20, 2019, at 9:10 AM, Mosleh Uddin <mosleh1235@gmail.com> wrot=
e:=20

> Hello,
> Here is what I do to get the consistent behavior:
> When the app is running as a service, lttng list -u does not display any =
events,
> initially I do have to lttng enable-events and lttng start to see the
> tracepoints in lttng view. However, after lttng start, I can disable all =
events
> and I can still see the events coming through in lttng view. When I run t=
he app
> normally, lttng list -u displays the tracepoints I place in the app, and =
all
> functionality of lttng works as expected.

> I apologize, I am in the process of trying to get you the outputs you are=
 asking
> for, however due to confidentiality with the app the outputs of running t=
he
> commands need to be reviewed by others. I will try to get this to you as =
soon
> as I can.

> I can say the service is being kick started by systemd. Also I believe th=
e app
> is mass-closing file descriptors when it is daemonizing. I tried to dynam=
ically
> load the liblttng-ust-fd.so but the behavior did not change.

Did you load both liblttng-ust-fork.so and liblttng-ust-fd.so with LD_PRELO=
AD when launching your application ?=20

If not using LD_PRELOAD env. var., how did you load them ?=20

Thanks,=20

Mathieu=20

> Thanks,
> Mosleh

> On Tue, Feb 19, 2019 at 5:16 PM Francis Deslauriers < [
> mailto:francis.deslauriers@efficios.com | francis.deslauriers@efficios.co=
m ] >
> wrote:

>> Hi Mosleh,
>> Just to be clear:
>> When you run your app as a service (background), lttng list -u doesn't
>> display any events AND you see events in the live session without
>> having run enable-event and start commands.
>> When you run your app normally, lttng list -u displays events AND you
>> only see events after running enable-event and start commands.
>> Is that correct?

>> Please provide the output of the lttng-sessiond in verbose mode using
>> the following command:
>> > lttng-sessiond -vvv
>> please provide the output of your application as a service with this
>> environment variable: LTTNG_UST_DEBUG=3D1
>> and please provide us with the service file describing how your
>> service is started.
>> Put all of this on a [ http://pastebin.com/ | pastebin.com ]

>> Is your application mass-closing file descriptors when it's
>> daemonizing? how about using fork() syscall without an exec() after
>> it? If so, have a look at this part of the UST man page:
>> [ https://lttng.org/man/3/lttng-ust/v2.10/#doc-_using_lttng_ust_with_dae=
mons |
>> https://lttng.org/man/3/lttng-ust/v2.10/#doc-_using_lttng_ust_with_daemo=
ns ]

>> Thank you,
>> Francis

>> Le mar. 19 f=C3=A9vr. 2019, =C3=A0 16 h 37, Mosleh Uddin < [ mailto:mosl=
eh1235@gmail.com |
>> mosleh1235@gmail.com ] > a =C3=A9crit :

>> > Hello,

>>> Sorry for the late reply. I was able to figure out the weird behavior f=
rom the
>>> application. Turns out if I run my application as a service, lttng no l=
onger
>> > can see any of the UST tracepoints and causes the behavior I was expla=
ining.
>>> When I execute the application normally (./app_name), the functionality=
 is as
>>> expected. Is this the expected behavior? Is there some way I can trace =
the
>> > userspace application while running it as a service simultaneously?

>> > Thanks for any info,
>> > Mosleh

>>> On Fri, Feb 15, 2019 at 2:48 PM Francis Deslauriers < [
>>> mailto:francis.deslauriers@efficios.com | francis.deslauriers@efficios.=
com ] >
>> > wrote:

>> >> Can you start the lttng-sessiond in verbose mode using the following =
command:
>> >> > lttng-sessiond -vvv
>>>> and then do the lttng create, start of application and lttng view on a=
nother
>> >> console.

>>>> Then copy the output of the sessiond on [ https://pastebin.com/ |
>> >> https://pastebin.com/ ] and send us the link.

>> >> Thank you,
>> >> Francis

>>>> Le ven. 15 f=C3=A9vr. 2019, =C3=A0 14 h 36, Mosleh Uddin < [ mailto:mo=
sleh1235@gmail.com |
>> >> mosleh1235@gmail.com ] > a =C3=A9crit :

>> >>> That's correct, I don't enable any events or do: lttng start.
>>>>> Here is some snapshots of starting everything up, followed by startin=
g my
>> >>> application.


>> >>> Here are the outputs for the commands:







>>>>> Note that even though the session is inactive, when a trace event occ=
urs in my
>> >>> application it is being recorded in the appropriate directory:



>>>>> Also maybe important, the system has root only user. Would having the
>>>>> application belonging to a different user and trying to run as root c=
ause these
>>>>> kinds of complications? I did notice when testing on a raspberry pi t=
hat
>>>>> running an application as a root user would mean running sessions as =
root user
>> >>> as well.

>> >>> Thanks,
>> >>> Mosleh

>>>>> On Fri, Feb 15, 2019 at 11:55 AM Francis Deslauriers < [
>>>>> mailto:francis.deslauriers@efficios.com | francis.deslauriers@efficio=
s.com ] >
>> >>> wrote:

>> >>>> Adding back lttng-dev mailing list.

>> >>>> So you don't even run a lttng-enable-event command?
>> >>>> That's odd.

>> >>>> Can you send us the output of the following commands:
>> >>>> Is it possible that there are other lttng-sessiond daemons running =
on
>> >>>> the machine?
>> >>>> > ps aux | grep "lttng-sessiond"
>> >>>> Verify if there are other active tracing sessions:
>> >>>> > lttng list
>> >>>> Check the details of the current session:
>> >>>> > lttng status

>> >>>> Thank you,
>> >>>> Francis

>>>>>> Le ven. 15 f=C3=A9vr. 2019, =C3=A0 11 h 29, Mosleh Uddin < [ mailto:=
mosleh1235@gmail.com |
>> >>>> mosleh1235@gmail.com ] > a =C3=A9crit :

>> >>>> > Hi Francis,

>> >>>> > Thank you for the quick response.
>> >>>> > Just to clear things up, my application is running when I run tha=
t command.

>> >>>> > The commands I am running are:
>> >>>> > > lttng-sessiond -d
>> >>>> > > lttng create my-sess --live
>> >>>> > After this command I start my application. If I then do the comma=
nd:
>> >>>> > > lttng view
>>>>>> > I will see the tracepoints in the application in the terminal even=
 though I have
>> >>>> > not done: lttng start.

>>>>>> > I thought it was strange that I cannot find my application in the:=
 lttng list
>> >>>> > command under any domain.
>>>>>> > Also the reason I start my application after creating a session is=
 because the
>> >>>> > system automatically starts the application using systemd,
>>>>>> > in order to get tracing data at all I have to manually stop the ap=
plication and
>> >>>> > start it again after creating a session.

>> >>>> > Thanks again for any help,
>> >>>> > Mosleh

>>>>>> > On Fri, Feb 15, 2019 at 10:32 AM Francis Deslauriers < [
>>>>>> > mailto:francis.deslauriers@efficios.com | francis.deslauriers@effi=
cios.com ] >
>> >>>> > wrote:

>> >>>> >> Hi Mosleh,
>> >>>> >> It's expected to not see any event when running lttng list -u if=
 no
>> >>>> >> lttng-ust instrumented applications are running.

>> >>>> >> What are the exact lttng commands you are running to see those
>> >>>> >> unexpected events?

>> >>>> >> Thank you,
>> >>>> >> Francis


>>>>>> >> Le ven. 15 f=C3=A9vr. 2019, =C3=A0 10 h 08, Mosleh Uddin < [ mail=
to:mosleh1235@gmail.com |
>> >>>> >> mosleh1235@gmail.com ] > a =C3=A9crit :

>> >>>> >> > Hello,

>>>>>> >> > I am having a strange issue with my current application. For so=
me context, I
>>>>>> >> > have integrated LTTng into a Yocto build and put custom trace p=
oints in my
>>>>>> >> > embedded system application. Once I load the built image onto m=
y system and
>>>>>> >> > start a session daemon, I try to list all available userspace e=
vents (using
>> >>>> >> > lttng list -u), but no events show up.

>>>>>> >> > The strange occurrence is when I create a session (lltng create=
 my-sess) and not
>>>>>> >> > start tracing the trace events will display on the screen regar=
dless (when
>>>>>> >> > starting session in live mode with lttng view). I was wondering=
 if anyone has
>> >>>> >> > any insight on this issue I am having.

>> >>>> >> > Thanks for any assistance,
>> >>>> >> > Mosleh
>> >>>> >> > _______________________________________________
>> >>>> >> > lttng-dev mailing list
>> >>>> >> > [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org=
 ]
>>>>>> >> > [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>> >>>> >> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> >>>> >> --
>> >>>> >> Francis Deslauriers
>> >>>> >> Computer Engineer
>> >>>> >> EfficiOS inc.



>> >>>> --
>> >>>> Francis Deslauriers
>> >>>> Computer Engineer
>> >>>> EfficiOS inc.

>> >>> _______________________________________________
>> >>> lttng-dev mailing list
>> >>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>> >>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]



>> >> --
>> >> Francis Deslauriers
>> >> Computer Engineer
>> >> EfficiOS inc.

>> --
>> Francis Deslauriers
>> Computer Engineer
>> EfficiOS inc.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_26d154aa-14be-41b2-9f66-5dfa1966c5ff
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On Feb 20, 2019, at 9:10 AM, Mosleh=
 Uddin &lt;mosleh1235@gmail.com&gt; wrote:<br></span></div><div data-marker=
=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;mar=
gin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt;"><div dir=3D"ltr">Hello,<br><div>Here is what I do to get the consisten=
t behavior:</div><div>When the app is running as a service, lttng list -u d=
oes not display any events, initially I do have to lttng enable-events and =
lttng start to see the tracepoints in lttng view. However, after lttng star=
t, I can disable all events and I can still see the events coming through i=
n lttng view. When I run the app normally, lttng list -u displays the trace=
points I place in the app, and all functionality of lttng works as expected=
.</div><br><div>I apologize, I am in the process of trying to get you the o=
utputs you are asking for, however due to confidentiality with the app the =
outputs of running the commands need to be reviewed by others. I will try t=
o get this to you as soon as I can.</div><br><div>I can say the service is =
being kick started by systemd. Also I believe the app is mass-closing file =
descriptors when it is daemonizing. I tried to dynamically load the liblttn=
g-ust-fd.so but the behavior did not change.&nbsp;</div></div></blockquote>=
<div><br></div><div>Did you load both liblttng-ust-fork.so and liblttng-ust=
-fd.so with LD_PRELOAD when launching your application ?<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>If not using LD_PRELO=
AD env. var., how did you load them ?<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div=
><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px s=
olid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal=
;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-se=
rif;font-size:12pt;"><div dir=3D"ltr"><br><div>Thanks,</div><div>Mosleh</di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Feb 19, 2019 at 5:16 PM Francis Deslauriers &lt;<a href=3D"mailto=
:francis.deslauriers@efficios.com" target=3D"_blank">francis.deslauriers@ef=
ficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Mosleh,<br>
Just to be clear:<br>
When you run your app as a service (background), lttng list -u doesn't<br>
display any events AND you see events in the live session without<br>
having run enable-event and start commands.<br>
When you run your app normally, lttng list -u displays events AND you<br>
only see events after running enable-event and start commands.<br>
Is that correct?<br>
<br>
Please provide the output of the lttng-sessiond in verbose mode using<br>
the following command:<br>
&gt; lttng-sessiond -vvv<br>
please provide the output of your application as a service with this<br>
environment variable:&nbsp; LTTNG_UST_DEBUG=3D1<br>
and please provide us with the service file describing how your<br>
service is started.<br>
Put all of this on a <a href=3D"http://pastebin.com" rel=3D"noreferrer" tar=
get=3D"_blank">pastebin.com</a><br>
<br>
Is your application mass-closing file descriptors when it's<br>
daemonizing? how about using fork() syscall without an exec() after<br>
it? If so, have a look at this part of the UST man page:<br>
<a href=3D"https://lttng.org/man/3/lttng-ust/v2.10/#doc-_using_lttng_ust_wi=
th_daemons" rel=3D"noreferrer" target=3D"_blank">https://lttng.org/man/3/lt=
tng-ust/v2.10/#doc-_using_lttng_ust_with_daemons</a><br>
<br>
Thank you,<br>
Francis<br>
<br>
<br>
Le mar. 19 f=C3=A9vr. 2019, =C3=A0 16 h 37, Mosleh Uddin &lt;<a href=3D"mai=
lto:mosleh1235@gmail.com" target=3D"_blank">mosleh1235@gmail.com</a>&gt; a =
=C3=A9crit :<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; Sorry for the late reply. I was able to figure out the weird behavior =
from the application. Turns out if I run my application as a service,&nbsp;=
 lttng no longer can see any of the UST tracepoints and causes the behavior=
 I was explaining.<br>
&gt; When I execute the application normally (./app_name), the functionalit=
y is as expected. Is this the expected behavior? Is there some way I can tr=
ace the userspace application while running it as a service simultaneously?=
<br>
&gt;<br>
&gt; Thanks for any info,<br>
&gt; Mosleh<br>
&gt;<br>
&gt; On Fri, Feb 15, 2019 at 2:48 PM Francis Deslauriers &lt;<a href=3D"mai=
lto:francis.deslauriers@efficios.com" target=3D"_blank">francis.deslauriers=
@efficios.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Can you start the lttng-sessiond in verbose mode using the followi=
ng command:<br>
&gt;&gt; &gt; lttng-sessiond -vvv<br>
&gt;&gt; and then do the lttng create, start of application and lttng view =
on another console.<br>
&gt;&gt;<br>
&gt;&gt; Then copy the output of the sessiond on <a href=3D"https://pastebi=
n.com/" rel=3D"noreferrer" target=3D"_blank">https://pastebin.com/</a> and =
send us the link.<br>
&gt;&gt;<br>
&gt;&gt; Thank you,<br>
&gt;&gt; Francis<br>
&gt;&gt;<br>
&gt;&gt; Le ven. 15 f=C3=A9vr. 2019, =C3=A0 14 h 36, Mosleh Uddin &lt;<a hr=
ef=3D"mailto:mosleh1235@gmail.com" target=3D"_blank">mosleh1235@gmail.com</=
a>&gt; a =C3=A9crit :<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; That's correct, I don't enable any events or do: lttng start.<=
br>
&gt;&gt;&gt; Here is some snapshots of starting everything up, followed by =
starting my application.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Here are the outputs for the commands:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Note that even though the session is inactive, when a trace ev=
ent occurs in my application it is being recorded in the appropriate direct=
ory:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Also maybe important, the system has root only user. Would hav=
ing the application belonging to a different user and trying to run as root=
 cause these kinds of complications? I did notice when testing on a raspber=
ry pi that running an application as a root user would mean running session=
s as root user as well.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; Mosleh<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Fri, Feb 15, 2019 at 11:55 AM Francis Deslauriers &lt;<a hr=
ef=3D"mailto:francis.deslauriers@efficios.com" target=3D"_blank">francis.de=
slauriers@efficios.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Adding back lttng-dev mailing list.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; So you don't even run a lttng-enable-event command?<br>
&gt;&gt;&gt;&gt; That's odd.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Can you send us the output of the following commands:<br>
&gt;&gt;&gt;&gt; Is it possible that there are other lttng-sessiond daemons=
 running on<br>
&gt;&gt;&gt;&gt; the machine?<br>
&gt;&gt;&gt;&gt; &gt; ps aux | grep "lttng-sessiond"<br>
&gt;&gt;&gt;&gt; Verify if there are other active tracing sessions:<br>
&gt;&gt;&gt;&gt; &gt; lttng list<br>
&gt;&gt;&gt;&gt; Check the details of the current session:<br>
&gt;&gt;&gt;&gt; &gt; lttng status<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thank you,<br>
&gt;&gt;&gt;&gt; Francis<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Le ven. 15 f=C3=A9vr. 2019, =C3=A0 11 h 29, Mosleh Uddin &=
lt;<a href=3D"mailto:mosleh1235@gmail.com" target=3D"_blank">mosleh1235@gma=
il.com</a>&gt; a =C3=A9crit :<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Hi Francis,<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Thank you for the quick response.<br>
&gt;&gt;&gt;&gt; &gt; Just to clear things up, my application is running wh=
en I run that command.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; The commands I am running are:<br>
&gt;&gt;&gt;&gt; &gt; &gt; lttng-sessiond -d<br>
&gt;&gt;&gt;&gt; &gt; &gt; lttng create my-sess --live<br>
&gt;&gt;&gt;&gt; &gt; After this command I start my application. If I then =
do the command:<br>
&gt;&gt;&gt;&gt; &gt; &gt; lttng view<br>
&gt;&gt;&gt;&gt; &gt; I will see the tracepoints in the application in the =
terminal even though I have not done: lttng start.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; I thought it was strange that I cannot find my applic=
ation in the: lttng list command under any domain.<br>
&gt;&gt;&gt;&gt; &gt; Also the reason I start my application after creating=
 a session is because the system automatically starts the application using=
 systemd,<br>
&gt;&gt;&gt;&gt; &gt; in order to get tracing data at all I have to manuall=
y stop the application and start it again after creating a session.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Thanks again for any help,<br>
&gt;&gt;&gt;&gt; &gt; Mosleh<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; On Fri, Feb 15, 2019 at 10:32 AM Francis Deslauriers =
&lt;<a href=3D"mailto:francis.deslauriers@efficios.com" target=3D"_blank">f=
rancis.deslauriers@efficios.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; Hi Mosleh,<br>
&gt;&gt;&gt;&gt; &gt;&gt; It's expected to not see any event when running l=
ttng list -u if no<br>
&gt;&gt;&gt;&gt; &gt;&gt; lttng-ust instrumented applications are running.<=
br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; What are the exact lttng commands you are running=
 to see those<br>
&gt;&gt;&gt;&gt; &gt;&gt; unexpected events?<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; Thank you,<br>
&gt;&gt;&gt;&gt; &gt;&gt; Francis<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; Le ven. 15 f=C3=A9vr. 2019, =C3=A0 10 h 08, Mosle=
h Uddin &lt;<a href=3D"mailto:mosleh1235@gmail.com" target=3D"_blank">mosle=
h1235@gmail.com</a>&gt; a =C3=A9crit :<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; Hello,<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; I am having a strange issue with my current =
application. For some context, I have integrated LTTng into a Yocto build a=
nd put custom trace points in my embedded system application. Once I load t=
he built image onto my system and start a session daemon, I try to list all=
 available userspace events (using lttng list -u), but no events show up.<b=
r>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; The strange occurrence is when I create a se=
ssion (lltng create my-sess) and not start tracing the trace events will di=
splay on the screen regardless (when starting session in live mode with ltt=
ng view). I was wondering if anyone has any insight on this issue I am havi=
ng.<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; Thanks for any assistance,<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; Mosleh<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; ____________________________________________=
___<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org"=
 target=3D"_blank">lttng-dev@lists.lttng.org</a><br>
&gt;&gt;&gt;&gt; &gt;&gt; &gt; <a href=3D"https://lists.lttng.org/cgi-bin/m=
ailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lis=
ts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt; Francis Deslauriers<br>
&gt;&gt;&gt;&gt; &gt;&gt; Computer Engineer<br>
&gt;&gt;&gt;&gt; &gt;&gt; EfficiOS inc.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; Francis Deslauriers<br>
&gt;&gt;&gt;&gt; Computer Engineer<br>
&gt;&gt;&gt;&gt; EfficiOS inc.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; lttng-dev mailing list<br>
&gt;&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank"=
>lttng-dev@lists.lttng.org</a><br>
&gt;&gt;&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-b=
in/mailman/listinfo/lttng-dev</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Francis Deslauriers<br>
&gt;&gt; Computer Engineer<br>
&gt;&gt; EfficiOS inc.<br>
<br>
<br>
<br>
-- <br>
Francis Deslauriers<br>
Computer Engineer<br>
EfficiOS inc.<br>
</blockquote></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_26d154aa-14be-41b2-9f66-5dfa1966c5ff--

--===============6006033575858441240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6006033575858441240==--

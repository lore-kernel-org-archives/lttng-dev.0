From: Mosleh Uddin <mosleh1235@gmail.com>
Subject: Re: Creating custom application
Date: Wed, 27 Mar 2019 12:09:54 -0400
Message-ID: <CAJyWpKHtXHAgyjwZVnSCnnDTmCsOVsydaZgqpMuALQWMy5nfiA__30998.9137154602$1553703071$gmane$org@mail.gmail.com>
References: <CAJyWpKHE_4eZwMAhU-q4sbAAA3-nPWgxtGqpXYLpMyztNzmm-w@mail.gmail.com>
 <20190326152942.GE17481@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7510039201793843927=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x12b.google.com (mail-it1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 by lists.lttng.org (Postfix) with ESMTPS id 44TtHy4S49z17tp
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2019 12:10:06 -0400 (EDT)
Received: by mail-it1-x12b.google.com with SMTP id l4so5966984ite.1
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2019 09:10:06 -0700 (PDT)
In-Reply-To: <20190326152942.GE17481@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7510039201793843927==
Content-Type: multipart/alternative; boundary="000000000000be3011058515abff"

--000000000000be3011058515abff
Content-Type: text/plain; charset="UTF-8"

Hello,

Thank you for the quick response. I was able to use the documentation you
provided to start a session and get tracepoint list. I do have some
follow-up questions:

1) I needed to create a session daemon before executing my custom
application. In the API I did see functionality to see if a daemon is
active, however, it is possible to spawn a session daemon in my custom app?

2) I am able to get a list of active traces lttng can see in userspace, I
enable all the traces and start tracing. The traces however seem to not be
written anywhere on my filesystem. Do I have to specify a location? Or am I
missing something? My current flow is:

   - Creating a session
   - Specifying the domain
   - Creating a handle
   - Creating a channel (with default attributes)
   - Enabling the channel
   - Enabling event (for all traces)
   - Start tracing

Thanks again for all the assistance.

Regards,
Mosleh

On Tue, Mar 26, 2019 at 11:29 AM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Mosleh,
>
> On Tue, Mar 26, 2019 at 11:11:41AM -0400, Mosleh Uddin wrote:
> > Hi all,
> >
> > I am working with an embedded system and for security purposes I don't
> > necessarily want the user to have the ability to execute lttng commands
> > (lttng-sessiond, lttng create, etc.). In order to create a session/start
> I
> > am creating a custom application which will communicate through my
> > application via a socket. This way my application only control lttng
> > functionalities.
> >
> > I was wondering if you guys can direct me to some documentation where I
> can
> > understand how I can approach creating a session and implementing the
> > functionalities that commands like (lttng-sessiond, lttng create and
> lttng
> > start) provide. Thank you for any information.
>
> Note that lttng-sessiond can be started with a specific group id for
> "control"
> purpose that allow only users of the group to control it. From there you
> could
> have a simple popen based custom application that run the cli client.
> There are
> multiple ways to achieve what you are looking for.
>
> We also expose an API/lib (liblttng-ctl) to talk to the sessiond [1].
>
> The best documentation on how to use this API is the headers [1] and the
> command
> line client implementation [3].
>
> [1] https://github.com/lttng/lttng-tools/tree/master/include/lttng
> [2] https://github.com/lttng/lttng-tools/tree/master/src/bin/lttng
>
> https://github.com/lttng/lttng-tools/tree/master/src/bin/lttng/commands
>
> Let us know how it goes.
>
> Cheers
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--000000000000be3011058515abff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Thank you for the quick response=
. I was able to use the documentation you provided to start a session and g=
et tracepoint list. I do have some follow-up questions:</div><div><br></div=
><div>1) I needed to create a session daemon before executing my custom app=
lication. In the API I did see functionality to see if a daemon is active, =
however, it is possible to spawn a session daemon in my custom app?</div><d=
iv><br></div><div>2) I am able to get a list of active traces lttng can see=
 in userspace, I enable all the traces and start tracing. The traces howeve=
r seem to not be written anywhere on my filesystem. Do I have to specify a =
location? Or am I missing something? My current flow is:</div><div><ul><li>=
Creating a session</li><li>Specifying the domain</li><li>Creating a handle<=
/li><li>Creating a channel (with default attributes)</li><li>Enabling the c=
hannel</li><li>Enabling event (for all traces)</li><li>Start tracing</li></=
ul><div>Thanks again for all the assistance.</div></div><div><br></div><div=
>Regards,</div><div>Mosleh</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 26, 2019 at 11:29 AM Jonathan R=
ajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">j=
onathan.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi Mosleh,<br>
<br>
On Tue, Mar 26, 2019 at 11:11:41AM -0400, Mosleh Uddin wrote:<br>
&gt; Hi all,<br>
&gt; <br>
&gt; I am working with an embedded system and for security purposes I don&#=
39;t<br>
&gt; necessarily want the user to have the ability to execute lttng command=
s<br>
&gt; (lttng-sessiond, lttng create, etc.). In order to create a session/sta=
rt I<br>
&gt; am creating a custom application which will communicate through my<br>
&gt; application via a socket. This way my application only control lttng<b=
r>
&gt; functionalities.<br>
&gt; <br>
&gt; I was wondering if you guys can direct me to some documentation where =
I can<br>
&gt; understand how I can approach creating a session and implementing the<=
br>
&gt; functionalities that commands like (lttng-sessiond, lttng create and l=
ttng<br>
&gt; start) provide. Thank you for any information.<br>
<br>
Note that lttng-sessiond can be started with a specific group id for &quot;=
control&quot;<br>
purpose that allow only users of the group to control it. From there you co=
uld<br>
have a simple popen based custom application that run the cli client. There=
 are<br>
multiple ways to achieve what you are looking for.<br>
<br>
We also expose an API/lib (liblttng-ctl) to talk to the sessiond [1].<br>
<br>
The best documentation on how to use this API is the headers [1] and the co=
mmand<br>
line client implementation [3].<br>
<br>
[1] <a href=3D"https://github.com/lttng/lttng-tools/tree/master/include/ltt=
ng" rel=3D"noreferrer" target=3D"_blank">https://github.com/lttng/lttng-too=
ls/tree/master/include/lttng</a><br>
[2] <a href=3D"https://github.com/lttng/lttng-tools/tree/master/src/bin/ltt=
ng" rel=3D"noreferrer" target=3D"_blank">https://github.com/lttng/lttng-too=
ls/tree/master/src/bin/lttng</a><br>
=C2=A0 =C2=A0 <a href=3D"https://github.com/lttng/lttng-tools/tree/master/s=
rc/bin/lttng/commands" rel=3D"noreferrer" target=3D"_blank">https://github.=
com/lttng/lttng-tools/tree/master/src/bin/lttng/commands</a><br>
<br>
Let us know how it goes.<br>
<br>
Cheers<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--000000000000be3011058515abff--

--===============7510039201793843927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7510039201793843927==--

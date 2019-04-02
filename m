From: Mosleh Uddin <mosleh1235@gmail.com>
Subject: Re: Creating custom application
Date: Tue, 2 Apr 2019 16:54:00 -0400
Message-ID: <CAJyWpKEhLdREuCFJEfSojHuqQ9jTA12SWE_FAJ3HTdP1irO-sw__3939.87955046526$1554238467$gmane$org@mail.gmail.com>
References: <CAJyWpKHE_4eZwMAhU-q4sbAAA3-nPWgxtGqpXYLpMyztNzmm-w@mail.gmail.com>
 <20190326152942.GE17481@joraj-alpa>
 <CAJyWpKHtXHAgyjwZVnSCnnDTmCsOVsydaZgqpMuALQWMy5nfiA@mail.gmail.com>
 <20190327175251.GA7976@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0028106848153086502=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x12f.google.com (mail-it1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 by lists.lttng.org (Postfix) with ESMTPS id 44YhK01rdBz17XK
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2019 16:54:12 -0400 (EDT)
Received: by mail-it1-x12f.google.com with SMTP id k64so7692182itb.5
 for <lttng-dev@lists.lttng.org>; Tue, 02 Apr 2019 13:54:11 -0700 (PDT)
In-Reply-To: <20190327175251.GA7976@joraj-alpa>
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

--===============0028106848153086502==
Content-Type: multipart/alternative; boundary="000000000000c7d6c90585925678"

--000000000000c7d6c90585925678
Content-Type: text/plain; charset="UTF-8"

Hello,

Could you give me some more insight into spawning my own sessiond? Sorry
I'm not completely clear on the topic.
Thank you for all your assistance.

Regards,
Mosleh

On Wed, Mar 27, 2019 at 1:52 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Mosleh,
>
> On Wed, Mar 27, 2019 at 12:09:54PM -0400, Mosleh Uddin wrote:
> > Hello,
> >
> > Thank you for the quick response. I was able to use the documentation you
> > provided to start a session and get tracepoint list. I do have some
> > follow-up questions:
> >
> > 1) I needed to create a session daemon before executing my custom
> > application. In the API I did see functionality to see if a daemon is
> > active, however, it is possible to spawn a session daemon in my custom
> app?
>
> liblttng-ctl does not expose a lttng-sessiond spawning function since by
> definition it is a daemon executable (think apache,mysql etc.), you will
> have to
> use system/popen/exec.. to spawn the lttng-sessiond process etc. if you
> want to
> control its lifetime using your custom application.
>
> >
> > 2) I am able to get a list of active traces lttng can see in userspace, I
> > enable all the traces and start tracing. The traces however seem to not
> be
> > written anywhere on my filesystem. Do I have to specify a location? Or
> am I
> > missing something? My current flow is:
>
> Please refer to the create command. If outputting locally you will need to
> pass
> a "file://...." url to lttng_create_session.
>
> You can check on the result for each steps using "lttng list" and "lttng
> list
> <session_name>" as you go to troubleshot your setup script.
>
> While debugging you can also start the lttng-sessiond in verbose mode to
> understand what is going on.
>
> Also note that you could also use the lttng "load" api if the session you
> are
> trying to load is "static" and always the same. You would only need to
> ship an
> xml file with your application.
>
> Cheers
>
> >
> >    - Creating a session
> >    - Specifying the domain
> >    - Creating a handle
> >    - Creating a channel (with default attributes)
> >    - Enabling the channel
> >    - Enabling event (for all traces)
> >    - Start tracing
> >
> > Thanks again for all the assistance.
> >
> > Regards,
> > Mosleh
> >
> > On Tue, Mar 26, 2019 at 11:29 AM Jonathan Rajotte-Julien <
> > jonathan.rajotte-julien@efficios.com> wrote:
> >
>

--000000000000c7d6c90585925678
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Could you give me some more insi=
ght into spawning my own sessiond? Sorry I&#39;m not completely clear on th=
e topic.</div><div>Thank you for all your assistance.</div><div><br></div><=
div>Regards,</div><div>Mosleh</div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 27, 2019 at 1:52 PM Jonathan=
 Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com"=
>jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi Mosleh,<br>
<br>
On Wed, Mar 27, 2019 at 12:09:54PM -0400, Mosleh Uddin wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; Thank you for the quick response. I was able to use the documentation =
you<br>
&gt; provided to start a session and get tracepoint list. I do have some<br=
>
&gt; follow-up questions:<br>
&gt; <br>
&gt; 1) I needed to create a session daemon before executing my custom<br>
&gt; application. In the API I did see functionality to see if a daemon is<=
br>
&gt; active, however, it is possible to spawn a session daemon in my custom=
 app?<br>
<br>
liblttng-ctl does not expose a lttng-sessiond spawning function since by<br=
>
definition it is a daemon executable (think apache,mysql etc.), you will ha=
ve to<br>
use system/popen/exec.. to spawn the lttng-sessiond process etc. if you wan=
t to<br>
control its lifetime using your custom application.<br>
<br>
&gt; <br>
&gt; 2) I am able to get a list of active traces lttng can see in userspace=
, I<br>
&gt; enable all the traces and start tracing. The traces however seem to no=
t be<br>
&gt; written anywhere on my filesystem. Do I have to specify a location? Or=
 am I<br>
&gt; missing something? My current flow is:<br>
<br>
Please refer to the create command. If outputting locally you will need to =
pass<br>
a &quot;file://....&quot; url to lttng_create_session.<br>
<br>
You can check on the result for each steps using &quot;lttng list&quot; and=
 &quot;lttng list<br>
&lt;session_name&gt;&quot; as you go to troubleshot your setup script.<br>
<br>
While debugging you can also start the lttng-sessiond in verbose mode to<br=
>
understand what is going on.<br>
<br>
Also note that you could also use the lttng &quot;load&quot; api if the ses=
sion you are<br>
trying to load is &quot;static&quot; and always the same. You would only ne=
ed to ship an<br>
xml file with your application.<br>
<br>
Cheers<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 - Creating a session<br>
&gt;=C2=A0 =C2=A0 - Specifying the domain<br>
&gt;=C2=A0 =C2=A0 - Creating a handle<br>
&gt;=C2=A0 =C2=A0 - Creating a channel (with default attributes)<br>
&gt;=C2=A0 =C2=A0 - Enabling the channel<br>
&gt;=C2=A0 =C2=A0 - Enabling event (for all traces)<br>
&gt;=C2=A0 =C2=A0 - Start tracing<br>
&gt; <br>
&gt; Thanks again for all the assistance.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Mosleh<br>
&gt; <br>
&gt; On Tue, Mar 26, 2019 at 11:29 AM Jonathan Rajotte-Julien &lt;<br>
&gt; <a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_bla=
nk">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; <br>
</blockquote></div>

--000000000000c7d6c90585925678--

--===============0028106848153086502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0028106848153086502==--

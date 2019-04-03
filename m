From: Mosleh Uddin <mosleh1235@gmail.com>
Subject: Re: Creating custom application
Date: Wed, 3 Apr 2019 11:04:19 -0400
Message-ID: <CAJyWpKGTZTKELQxb_XfnEhEjzMmSWe6oarR_XgS-9qmkoKfvNA__29334.3785729789$1554303893$gmane$org@mail.gmail.com>
References: <CAJyWpKHE_4eZwMAhU-q4sbAAA3-nPWgxtGqpXYLpMyztNzmm-w@mail.gmail.com>
 <20190326152942.GE17481@joraj-alpa>
 <CAJyWpKHtXHAgyjwZVnSCnnDTmCsOVsydaZgqpMuALQWMy5nfiA@mail.gmail.com>
 <20190327175251.GA7976@joraj-alpa>
 <CAJyWpKEhLdREuCFJEfSojHuqQ9jTA12SWE_FAJ3HTdP1irO-sw@mail.gmail.com>
 <20190402211757.GA23381@joraj-alpa>
 <CAJyWpKGDrF9J=yDALm+1cn7cTd+TJZK30tXLHKKKXvkntmQDoQ@mail.gmail.com>
 <CAJyWpKFxRqsVYc=dDvaoTMGkrkLmktaudYJgvVkzzvUyeFx-NQ@mail.gmail.com>
 <20190403142514.GB23381@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6706187095305262679=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by lists.lttng.org (Postfix) with ESMTPS id 44Z8W35Dygz1K8k
 for <lttng-dev@lists.lttng.org>; Wed,  3 Apr 2019 11:04:31 -0400 (EDT)
Received: by mail-io1-xd30.google.com with SMTP id c4so14322409ioh.9
 for <lttng-dev@lists.lttng.org>; Wed, 03 Apr 2019 08:04:31 -0700 (PDT)
In-Reply-To: <20190403142514.GB23381@joraj-alpa>
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

--===============6706187095305262679==
Content-Type: multipart/alternative; boundary="0000000000001522d40585a19286"

--0000000000001522d40585a19286
Content-Type: text/plain; charset="UTF-8"

Hello,

It is a limitation for both size and some security measures. We want to
ensure that we can set limits controlled by our custom application.

For testing purposes, I did initially have lttng-tools and lttng-ust added
to the build image but again for the limitations described it cannot go
into the final 'production' rootfs. So it's nice that the service file
exists, but without the tools installed I do not think I can make use of
it, unless there is a way to strip out everything from lttng-tools except
for the sessiond functionality.

My guess from everything you are saying is that I will have to create a
custom method for spawning a session daemon without having lttng-tools
available, however I am unsure where to start. From way lttng-tools does
it, I see it call the executable 'lttng-sessiond', but I cannot find a
reference to when or how that executable is getting built.

Thanks again for quick responses.

Regards,
Mosleh



On Wed, Apr 3, 2019 at 10:25 AM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> On Wed, Apr 03, 2019 at 09:08:45AM -0400, Mosleh Uddin wrote:
> > Hello,
> >
> > Sorry, I should be more specific. I am creating a custom yocto build. I
> > have seen some examples where systemd is utilized to start the sessiond
> as
> > a service. The limitation I have is that I don't want to include the
> whole
> > lttng-tools librray in my build. I understand that the sessiond is an
>
> You will have to if you plan on tracing any applications on your resulting
> image. Why is it a limitation? Size constraint?
>
> lttng-tools is already part of OE-core (the meta/ layer). Use this recipe
> to
> build it [1] or as a base for a custom one.
>
> [1]
> https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/recipes-kernel/lttng/lttng-tools_2.10.6.bb
>
> You can add the following to your local.conf file to build only lttng-ust
> and
> lttng-tools.
>
> CORE_IMAGE_EXTRA_INSTALL += "lttng-ust lttng-tools"
> PACKAGECONFIG_pn-lttng-tools_append = " lttng-ust"
>
> By default a systemd service file is installed but is not activated (which
> seems
> to be what you want).
>
> Cheers
>
>
> > executable, I am just unsure how I could build or get this in my build.
> > Moving forward from this I could use fork/exec to daemonize which would
> be
> > simple.
> > Is there perhaps a existing recipe?
> >
> > Regards,
> > Mosleh
> >
> > On Tue, Apr 2, 2019 at 6:01 PM Mosleh Uddin <mosleh1235@gmail.com>
> wrote:
> >
> > > Hi,
> > >
> > > That makes complete sense. I was more curious about the sessiond
> > > executable. I'm guessing this is something I will have to create along
> with
> > > my build?
> > >
> > > Regards,
> > > Mosleh
> > >
> > > On Tue, Apr 2, 2019 at 5:18 PM Jonathan Rajotte-Julien <
> > > jonathan.rajotte-julien@efficios.com> wrote:
> > >
> > >> On Tue, Apr 02, 2019 at 04:54:00PM -0400, Mosleh Uddin wrote:
> > >> > Hello,
> > >> >
> > >> > Could you give me some more insight into spawning my own sessiond?
> Sorry
> > >> > I'm not completely clear on the topic.
> > >> > Thank you for all your assistance.
> > >>
> > >> Normally lttng-sessiond is treated as a "server/service/daemon" (think
> > >> http
> > >> server as apache) and is *normally* launched as a daemon
> > >> (systemd/sysVinit) at
> > >> boot time.
> > >>
> > >> Managing manually the lifetime of a lttng-sessiond process is done the
> > >> same way
> > >> as any other process. You can manage it via the command line
> > >> (./lttng-sessiond), via a
> > >> service manager (systemd/upstart etc.) or with a custom service
> manager (a
> > >> python script/c etc.).
> > >>
> > >> You could spawn a lttng-sessiond from your application with the
> > >> appropriate
> > >> parameters set to isolate it if you need. LTTNG_HOME is an important
> one.
> > >> The
> > >> output directory also can be manipulated. See man lttng-sessiond for
> more
> > >> details. You will need to manage the process or leave it to a system
> > >> administrator and only active tracing when a sessiond is present for
> > >> example.
> > >>
> > >> Cheers
> > >>
> > >> >
> > >> > Regards,
> > >> > Mosleh
> > >> >
> > >> > On Wed, Mar 27, 2019 at 1:52 PM Jonathan Rajotte-Julien <
> > >> > jonathan.rajotte-julien@efficios.com> wrote:
> > >> >
> > >> > > Hi Mosleh,
> > >> > >
> > >> > > On Wed, Mar 27, 2019 at 12:09:54PM -0400, Mosleh Uddin wrote:
> > >> > > > Hello,
> > >> > > >
> > >> > > > Thank you for the quick response. I was able to use the
> > >> documentation you
> > >> > > > provided to start a session and get tracepoint list. I do have
> some
> > >> > > > follow-up questions:
> > >> > > >
> > >> > > > 1) I needed to create a session daemon before executing my
> custom
> > >> > > > application. In the API I did see functionality to see if a
> daemon
> > >> is
> > >> > > > active, however, it is possible to spawn a session daemon in my
> > >> custom
> > >> > > app?
> > >> > >
> > >> > > liblttng-ctl does not expose a lttng-sessiond spawning function
> since
> > >> by
> > >> > > definition it is a daemon executable (think apache,mysql etc.),
> you
> > >> will
> > >> > > have to
> > >> > > use system/popen/exec.. to spawn the lttng-sessiond process etc.
> if
> > >> you
> > >> > > want to
> > >> > > control its lifetime using your custom application.
> > >> > >
> > >> > > >
> > >> > > > 2) I am able to get a list of active traces lttng can see in
> > >> userspace, I
> > >> > > > enable all the traces and start tracing. The traces however
> seem to
> > >> not
> > >> > > be
> > >> > > > written anywhere on my filesystem. Do I have to specify a
> location?
> > >> Or
> > >> > > am I
> > >> > > > missing something? My current flow is:
> > >> > >
> > >> > > Please refer to the create command. If outputting locally you will
> > >> need to
> > >> > > pass
> > >> > > a "file://...." url to lttng_create_session.
> > >> > >
> > >> > > You can check on the result for each steps using "lttng list" and
> > >> "lttng
> > >> > > list
> > >> > > <session_name>" as you go to troubleshot your setup script.
> > >> > >
> > >> > > While debugging you can also start the lttng-sessiond in verbose
> mode
> > >> to
> > >> > > understand what is going on.
> > >> > >
> > >> > > Also note that you could also use the lttng "load" api if the
> session
> > >> you
> > >> > > are
> > >> > > trying to load is "static" and always the same. You would only
> need to
> > >> > > ship an
> > >> > > xml file with your application.
> > >> > >
> > >> > > Cheers
> > >> > >
> > >> > > >
> > >> > > >    - Creating a session
> > >> > > >    - Specifying the domain
> > >> > > >    - Creating a handle
> > >> > > >    - Creating a channel (with default attributes)
> > >> > > >    - Enabling the channel
> > >> > > >    - Enabling event (for all traces)
> > >> > > >    - Start tracing
> > >> > > >
> > >> > > > Thanks again for all the assistance.
> > >> > > >
> > >> > > > Regards,
> > >> > > > Mosleh
> > >> > > >
> > >> > > > On Tue, Mar 26, 2019 at 11:29 AM Jonathan Rajotte-Julien <
> > >> > > > jonathan.rajotte-julien@efficios.com> wrote:
> > >> > > >
> > >> > >
> > >>
> > >> --
> > >> Jonathan Rajotte-Julien
> > >> EfficiOS
> > >>
> > >
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--0000000000001522d40585a19286
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>It is a limitation for both size=
 and some security measures. We want to ensure that we can set limits contr=
olled by our custom application.</div><div><br></div><div>For testing purpo=
ses, I did initially have lttng-tools and lttng-ust added to the build imag=
e but again for the limitations described it cannot go into the final &#39;=
production&#39; rootfs. So it&#39;s nice that the service file exists, but =
without the tools installed I do not think I can make use of it, unless the=
re is a way to strip out everything from lttng-tools except for the session=
d functionality.=C2=A0</div><div><br></div><div>My guess from everything yo=
u are saying is that I will have to create a custom method for spawning a s=
ession daemon without having lttng-tools available, however I am unsure whe=
re to start. From way lttng-tools does it, I see it call the executable &#3=
9;lttng-sessiond&#39;, but I cannot find a reference to when or how that ex=
ecutable is getting built.=C2=A0</div><div><br></div><div>Thanks again for =
quick responses.=C2=A0</div><div><br></div><div>Regards,</div><div>Mosleh=
=C2=A0</div><div><br></div><div><br></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 3, 2019 at 10:25 AM J=
onathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@effici=
os.com">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Wed, Apr 03, 2019 at 09:08:4=
5AM -0400, Mosleh Uddin wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; Sorry, I should be more specific. I am creating a custom yocto build. =
I<br>
&gt; have seen some examples where systemd is utilized to start the session=
d as<br>
&gt; a service. The limitation I have is that I don&#39;t want to include t=
he whole<br>
&gt; lttng-tools librray in my build. I understand that the sessiond is an<=
br>
<br>
You will have to if you plan on tracing any applications on your resulting<=
br>
image. Why is it a limitation? Size constraint?<br>
<br>
lttng-tools is already part of OE-core (the meta/ layer). Use this recipe t=
o<br>
build it [1] or as a base for a custom one.<br>
<br>
[1] <a href=3D"https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/re=
cipes-kernel/lttng/lttng-tools_2.10.6.bb" rel=3D"noreferrer" target=3D"_bla=
nk">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/recipes-kerne=
l/lttng/lttng-tools_2.10.6.bb</a><br>
<br>
You can add the following to your local.conf file to build only lttng-ust a=
nd<br>
lttng-tools.<br>
<br>
CORE_IMAGE_EXTRA_INSTALL +=3D &quot;lttng-ust lttng-tools&quot;<br>
PACKAGECONFIG_pn-lttng-tools_append =3D &quot; lttng-ust&quot;<br>
<br>
By default a systemd service file is installed but is not activated (which =
seems<br>
to be what you want).<br>
<br>
Cheers<br>
<br>
<br>
&gt; executable, I am just unsure how I could build or get this in my build=
.<br>
&gt; Moving forward from this I could use fork/exec to daemonize which woul=
d be<br>
&gt; simple.<br>
&gt; Is there perhaps a existing recipe?<br>
&gt; <br>
&gt; Regards,<br>
&gt; Mosleh<br>
&gt; <br>
&gt; On Tue, Apr 2, 2019 at 6:01 PM Mosleh Uddin &lt;<a href=3D"mailto:mosl=
eh1235@gmail.com" target=3D"_blank">mosleh1235@gmail.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; That makes complete sense. I was more curious about the sessiond<=
br>
&gt; &gt; executable. I&#39;m guessing this is something I will have to cre=
ate along with<br>
&gt; &gt; my build?<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; Mosleh<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Apr 2, 2019 at 5:18 PM Jonathan Rajotte-Julien &lt;<br>
&gt; &gt; <a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D=
"_blank">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; On Tue, Apr 02, 2019 at 04:54:00PM -0400, Mosleh Uddin wrote:=
<br>
&gt; &gt;&gt; &gt; Hello,<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Could you give me some more insight into spawning my own=
 sessiond? Sorry<br>
&gt; &gt;&gt; &gt; I&#39;m not completely clear on the topic.<br>
&gt; &gt;&gt; &gt; Thank you for all your assistance.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Normally lttng-sessiond is treated as a &quot;server/service/=
daemon&quot; (think<br>
&gt; &gt;&gt; http<br>
&gt; &gt;&gt; server as apache) and is *normally* launched as a daemon<br>
&gt; &gt;&gt; (systemd/sysVinit) at<br>
&gt; &gt;&gt; boot time.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Managing manually the lifetime of a lttng-sessiond process is=
 done the<br>
&gt; &gt;&gt; same way<br>
&gt; &gt;&gt; as any other process. You can manage it via the command line<=
br>
&gt; &gt;&gt; (./lttng-sessiond), via a<br>
&gt; &gt;&gt; service manager (systemd/upstart etc.) or with a custom servi=
ce manager (a<br>
&gt; &gt;&gt; python script/c etc.).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; You could spawn a lttng-sessiond from your application with t=
he<br>
&gt; &gt;&gt; appropriate<br>
&gt; &gt;&gt; parameters set to isolate it if you need. LTTNG_HOME is an im=
portant one.<br>
&gt; &gt;&gt; The<br>
&gt; &gt;&gt; output directory also can be manipulated. See man lttng-sessi=
ond for more<br>
&gt; &gt;&gt; details. You will need to manage the process or leave it to a=
 system<br>
&gt; &gt;&gt; administrator and only active tracing when a sessiond is pres=
ent for<br>
&gt; &gt;&gt; example.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Cheers<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Regards,<br>
&gt; &gt;&gt; &gt; Mosleh<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; On Wed, Mar 27, 2019 at 1:52 PM Jonathan Rajotte-Julien =
&lt;<br>
&gt; &gt;&gt; &gt; <a href=3D"mailto:jonathan.rajotte-julien@efficios.com" =
target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; Hi Mosleh,<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; On Wed, Mar 27, 2019 at 12:09:54PM -0400, Mosleh Ud=
din wrote:<br>
&gt; &gt;&gt; &gt; &gt; &gt; Hello,<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; Thank you for the quick response. I was able t=
o use the<br>
&gt; &gt;&gt; documentation you<br>
&gt; &gt;&gt; &gt; &gt; &gt; provided to start a session and get tracepoint=
 list. I do have some<br>
&gt; &gt;&gt; &gt; &gt; &gt; follow-up questions:<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; 1) I needed to create a session daemon before =
executing my custom<br>
&gt; &gt;&gt; &gt; &gt; &gt; application. In the API I did see functionalit=
y to see if a daemon<br>
&gt; &gt;&gt; is<br>
&gt; &gt;&gt; &gt; &gt; &gt; active, however, it is possible to spawn a ses=
sion daemon in my<br>
&gt; &gt;&gt; custom<br>
&gt; &gt;&gt; &gt; &gt; app?<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; liblttng-ctl does not expose a lttng-sessiond spawn=
ing function since<br>
&gt; &gt;&gt; by<br>
&gt; &gt;&gt; &gt; &gt; definition it is a daemon executable (think apache,=
mysql etc.), you<br>
&gt; &gt;&gt; will<br>
&gt; &gt;&gt; &gt; &gt; have to<br>
&gt; &gt;&gt; &gt; &gt; use system/popen/exec.. to spawn the lttng-sessiond=
 process etc. if<br>
&gt; &gt;&gt; you<br>
&gt; &gt;&gt; &gt; &gt; want to<br>
&gt; &gt;&gt; &gt; &gt; control its lifetime using your custom application.=
<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; 2) I am able to get a list of active traces lt=
tng can see in<br>
&gt; &gt;&gt; userspace, I<br>
&gt; &gt;&gt; &gt; &gt; &gt; enable all the traces and start tracing. The t=
races however seem to<br>
&gt; &gt;&gt; not<br>
&gt; &gt;&gt; &gt; &gt; be<br>
&gt; &gt;&gt; &gt; &gt; &gt; written anywhere on my filesystem. Do I have t=
o specify a location?<br>
&gt; &gt;&gt; Or<br>
&gt; &gt;&gt; &gt; &gt; am I<br>
&gt; &gt;&gt; &gt; &gt; &gt; missing something? My current flow is:<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; Please refer to the create command. If outputting l=
ocally you will<br>
&gt; &gt;&gt; need to<br>
&gt; &gt;&gt; &gt; &gt; pass<br>
&gt; &gt;&gt; &gt; &gt; a &quot;file://....&quot; url to lttng_create_sessi=
on.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; You can check on the result for each steps using &q=
uot;lttng list&quot; and<br>
&gt; &gt;&gt; &quot;lttng<br>
&gt; &gt;&gt; &gt; &gt; list<br>
&gt; &gt;&gt; &gt; &gt; &lt;session_name&gt;&quot; as you go to troubleshot=
 your setup script.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; While debugging you can also start the lttng-sessio=
nd in verbose mode<br>
&gt; &gt;&gt; to<br>
&gt; &gt;&gt; &gt; &gt; understand what is going on.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; Also note that you could also use the lttng &quot;l=
oad&quot; api if the session<br>
&gt; &gt;&gt; you<br>
&gt; &gt;&gt; &gt; &gt; are<br>
&gt; &gt;&gt; &gt; &gt; trying to load is &quot;static&quot; and always the=
 same. You would only need to<br>
&gt; &gt;&gt; &gt; &gt; ship an<br>
&gt; &gt;&gt; &gt; &gt; xml file with your application.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; Cheers<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Creating a session<br>
&gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Specifying the domain<br>
&gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Creating a handle<br>
&gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Creating a channel (with defaul=
t attributes)<br>
&gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Enabling the channel<br>
&gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Enabling event (for all traces)=
<br>
&gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Start tracing<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; Thanks again for all the assistance.<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; Regards,<br>
&gt; &gt;&gt; &gt; &gt; &gt; Mosleh<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; On Tue, Mar 26, 2019 at 11:29 AM Jonathan Rajo=
tte-Julien &lt;<br>
&gt; &gt;&gt; &gt; &gt; &gt; <a href=3D"mailto:jonathan.rajotte-julien@effi=
cios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt; wr=
ote:<br>
&gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; Jonathan Rajotte-Julien<br>
&gt; &gt;&gt; EfficiOS<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--0000000000001522d40585a19286--

--===============6706187095305262679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6706187095305262679==--

From: Mosleh Uddin <mosleh1235@gmail.com>
Subject: Re: Creating custom application
Date: Wed, 3 Apr 2019 16:50:15 -0400
Message-ID: <CAJyWpKFFM7Lvm5A--Fh=EUA6eFhOyy5=tpPM9pypSrbELwutxg__40866.2454968848$1554324647$gmane$org@mail.gmail.com>
References: <CAJyWpKHtXHAgyjwZVnSCnnDTmCsOVsydaZgqpMuALQWMy5nfiA@mail.gmail.com>
 <20190327175251.GA7976@joraj-alpa>
 <CAJyWpKEhLdREuCFJEfSojHuqQ9jTA12SWE_FAJ3HTdP1irO-sw@mail.gmail.com>
 <20190402211757.GA23381@joraj-alpa>
 <CAJyWpKGDrF9J=yDALm+1cn7cTd+TJZK30tXLHKKKXvkntmQDoQ@mail.gmail.com>
 <CAJyWpKFxRqsVYc=dDvaoTMGkrkLmktaudYJgvVkzzvUyeFx-NQ@mail.gmail.com>
 <20190403142514.GB23381@joraj-alpa>
 <CAJyWpKGTZTKELQxb_XfnEhEjzMmSWe6oarR_XgS-9qmkoKfvNA@mail.gmail.com>
 <20190403155531.GA8451@joraj-alpa>
 <CAJyWpKH0RSfkTNmDqasq+1KoSOdL6VFA84vBSWH6xpYqdOMRLQ@mail.gmail.com>
 <20190403200054.GC8743@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8426252797376551026=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x131.google.com (mail-it1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 by lists.lttng.org (Postfix) with ESMTPS id 44ZJBD26JBz1KjK
 for <lttng-dev@lists.lttng.org>; Wed,  3 Apr 2019 16:50:28 -0400 (EDT)
Received: by mail-it1-x131.google.com with SMTP id z126so153671itd.5
 for <lttng-dev@lists.lttng.org>; Wed, 03 Apr 2019 13:50:28 -0700 (PDT)
In-Reply-To: <20190403200054.GC8743@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8426252797376551026==
Content-Type: multipart/alternative; boundary="00000000000043a6530585a66731"

--00000000000043a6530585a66731
Content-Type: text/plain; charset="UTF-8"

Apologies, did not mean for the message to be private.

Thank you for all your assistance, for now I think compiling with the flag
to disable cli is the way to go.

Regards,
Mosleh

On Wed, Apr 3, 2019 at 4:00 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Mosleh,
>
> I just saw this was a private email.
>
> As you will understand based on my previous email, this is slowly starting
> the
> be out of scope of our public support effort.
>
> Note that we do offer commercial support if it is something you would be
> interested in. You would be able to talk openly of the requirements, more
> importantly of the project you are working on and how to integrate lttng
> with
> it.
>
> Cheers
>
> On Wed, Apr 03, 2019 at 02:15:55PM -0400, Mosleh Uddin wrote:
> > I apologize, I will give the bigger picture of what I am trying to do.
> >
> > So the restraint I have is that I can't install lttng-tools and lttng-ust
> > libraries as part of the yocto build, mostly because we have release
> > software (for the public) and we don't want these CLI features available
> to
> > the public (if they were to somehow access the CLI).
> >
> > I have compiled a userspace application using the 'lttng-ust' compile
> flag
> > with lttng tracepoints distributed throughout the code. I am creating a
> > separate custom lttng application (compiled with lttng-ctl) which will
> > communicate with the application (via domain socket) in order to dictate
> > when to start/stop sessions. I want the this custom application to have
> the
> > ability to not only start/stop sessions but also spawn the session
> daemon.
> >
> > From my description, you see that the system we are building for will not
> > any have lttng libraries installed, I will be cross-compiling the
> > applications with the libraries that are needed. I know you said
> lttng-ctl
> > doesn't expose spawning sessiond, so I was curious how I could get this
> > functionality for my custom lttng application.
> >
> > Regards,
> > Mosleh
> >
> > On Wed, Apr 3, 2019 at 11:55 AM Jonathan Rajotte-Julien <
> > jonathan.rajotte-julien@efficios.com> wrote:
> >
> > > On Wed, Apr 03, 2019 at 11:04:19AM -0400, Mosleh Uddin wrote:
> > > > Hello,
> > > >
> > > > It is a limitation for both size and some security measures. We want
> to
> > > > ensure that we can set limits controlled by our custom application.
> > >
> > > What security measure? What limits? Unless you provide clear
> requirement
> > > it is
> > > quite hard to understand where you are going and how we can help you
> get
> > > there.
> > >
> > > >
> > > > For testing purposes, I did initially have lttng-tools and lttng-ust
> > > added
> > > > to the build image but again for the limitations described it cannot
> go
> > > > into the final 'production' rootfs. So it's nice that the service
> file
> > > > exists, but without the tools installed I do not think I can make
> use of
> > > > it, unless there is a way to strip out everything from lttng-tools
> except
> > > > for the sessiond functionality.
> > >
> > > Well the biggest part of lttng-tools project is lttng-sessiond and
> > > lttng-consumerd. If the cli is the problem you can pass
> > > "--disable-bin-lttng" at
> > > configure time to simply exclude it from being built and installed.
> > >
> > > As for lttng-sessiond executable, you can limit the user able to use
> it via
> > > regular user/group permissions.
> > >
> > > >
> > > > My guess from everything you are saying is that I will have to
> create a
> > > > custom method for spawning a session daemon without having
> lttng-tools
> > > > available, however I am unsure where to start.
> > >
> > > No, you will need lttng-tools (in the sense of the project, no the
> > > executable) to
> > > be present on the system if you want to trace at all.
> > >
> > > > From way lttng-tools does
> > > > it, I see it call the executable 'lttng-sessiond', but I cannot find
> a
> > > > reference to when or how that executable is getting built.
> > >
> > > Take a look at the src/bin folder (git tree). The "lttng" subfolder is
> > > only the
> > > CLI. The meat of lttng is lttng-sessiond/relayd/consumerd.
> > >
> > > >
> > > > Thanks again for quick responses.
> > > >
> > > > Regards,
> > > > Mosleh
> > > >
> > > >
> > > >
> > > > On Wed, Apr 3, 2019 at 10:25 AM Jonathan Rajotte-Julien <
> > > > jonathan.rajotte-julien@efficios.com> wrote:
> > > >
> > > > > On Wed, Apr 03, 2019 at 09:08:45AM -0400, Mosleh Uddin wrote:
> > > > > > Hello,
> > > > > >
> > > > > > Sorry, I should be more specific. I am creating a custom yocto
> > > build. I
> > > > > > have seen some examples where systemd is utilized to start the
> > > sessiond
> > > > > as
> > > > > > a service. The limitation I have is that I don't want to include
> the
> > > > > whole
> > > > > > lttng-tools librray in my build. I understand that the sessiond
> is an
> > > > >
> > > > > You will have to if you plan on tracing any applications on your
> > > resulting
> > > > > image. Why is it a limitation? Size constraint?
> > > > >
> > > > > lttng-tools is already part of OE-core (the meta/ layer). Use this
> > > recipe
> > > > > to
> > > > > build it [1] or as a base for a custom one.
> > > > >
> > > > > [1]
> > > > >
> > >
> https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/recipes-kernel/lttng/lttng-tools_2.10.6.bb
> > > > >
> > > > > You can add the following to your local.conf file to build only
> > > lttng-ust
> > > > > and
> > > > > lttng-tools.
> > > > >
> > > > > CORE_IMAGE_EXTRA_INSTALL += "lttng-ust lttng-tools"
> > > > > PACKAGECONFIG_pn-lttng-tools_append = " lttng-ust"
> > > > >
> > > > > By default a systemd service file is installed but is not activated
> > > (which
> > > > > seems
> > > > > to be what you want).
> > > > >
> > > > > Cheers
> > > > >
> > > > >
> > > > > > executable, I am just unsure how I could build or get this in my
> > > build.
> > > > > > Moving forward from this I could use fork/exec to daemonize which
> > > would
> > > > > be
> > > > > > simple.
> > > > > > Is there perhaps a existing recipe?
> > > > > >
> > > > > > Regards,
> > > > > > Mosleh
> > > > > >
> > > > > > On Tue, Apr 2, 2019 at 6:01 PM Mosleh Uddin <
> mosleh1235@gmail.com>
> > > > > wrote:
> > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > That makes complete sense. I was more curious about the
> sessiond
> > > > > > > executable. I'm guessing this is something I will have to
> create
> > > along
> > > > > with
> > > > > > > my build?
> > > > > > >
> > > > > > > Regards,
> > > > > > > Mosleh
> > > > > > >
> > > > > > > On Tue, Apr 2, 2019 at 5:18 PM Jonathan Rajotte-Julien <
> > > > > > > jonathan.rajotte-julien@efficios.com> wrote:
> > > > > > >
> > > > > > >> On Tue, Apr 02, 2019 at 04:54:00PM -0400, Mosleh Uddin wrote:
> > > > > > >> > Hello,
> > > > > > >> >
> > > > > > >> > Could you give me some more insight into spawning my own
> > > sessiond?
> > > > > Sorry
> > > > > > >> > I'm not completely clear on the topic.
> > > > > > >> > Thank you for all your assistance.
> > > > > > >>
> > > > > > >> Normally lttng-sessiond is treated as a
> "server/service/daemon"
> > > (think
> > > > > > >> http
> > > > > > >> server as apache) and is *normally* launched as a daemon
> > > > > > >> (systemd/sysVinit) at
> > > > > > >> boot time.
> > > > > > >>
> > > > > > >> Managing manually the lifetime of a lttng-sessiond process is
> > > done the
> > > > > > >> same way
> > > > > > >> as any other process. You can manage it via the command line
> > > > > > >> (./lttng-sessiond), via a
> > > > > > >> service manager (systemd/upstart etc.) or with a custom
> service
> > > > > manager (a
> > > > > > >> python script/c etc.).
> > > > > > >>
> > > > > > >> You could spawn a lttng-sessiond from your application with
> the
> > > > > > >> appropriate
> > > > > > >> parameters set to isolate it if you need. LTTNG_HOME is an
> > > important
> > > > > one.
> > > > > > >> The
> > > > > > >> output directory also can be manipulated. See man
> lttng-sessiond
> > > for
> > > > > more
> > > > > > >> details. You will need to manage the process or leave it to a
> > > system
> > > > > > >> administrator and only active tracing when a sessiond is
> present
> > > for
> > > > > > >> example.
> > > > > > >>
> > > > > > >> Cheers
> > > > > > >>
> > > > > > >> >
> > > > > > >> > Regards,
> > > > > > >> > Mosleh
> > > > > > >> >
> > > > > > >> > On Wed, Mar 27, 2019 at 1:52 PM Jonathan Rajotte-Julien <
> > > > > > >> > jonathan.rajotte-julien@efficios.com> wrote:
> > > > > > >> >
> > > > > > >> > > Hi Mosleh,
> > > > > > >> > >
> > > > > > >> > > On Wed, Mar 27, 2019 at 12:09:54PM -0400, Mosleh Uddin
> wrote:
> > > > > > >> > > > Hello,
> > > > > > >> > > >
> > > > > > >> > > > Thank you for the quick response. I was able to use the
> > > > > > >> documentation you
> > > > > > >> > > > provided to start a session and get tracepoint list. I
> do
> > > have
> > > > > some
> > > > > > >> > > > follow-up questions:
> > > > > > >> > > >
> > > > > > >> > > > 1) I needed to create a session daemon before executing
> my
> > > > > custom
> > > > > > >> > > > application. In the API I did see functionality to see
> if a
> > > > > daemon
> > > > > > >> is
> > > > > > >> > > > active, however, it is possible to spawn a session
> daemon
> > > in my
> > > > > > >> custom
> > > > > > >> > > app?
> > > > > > >> > >
> > > > > > >> > > liblttng-ctl does not expose a lttng-sessiond spawning
> > > function
> > > > > since
> > > > > > >> by
> > > > > > >> > > definition it is a daemon executable (think apache,mysql
> > > etc.),
> > > > > you
> > > > > > >> will
> > > > > > >> > > have to
> > > > > > >> > > use system/popen/exec.. to spawn the lttng-sessiond
> process
> > > etc.
> > > > > if
> > > > > > >> you
> > > > > > >> > > want to
> > > > > > >> > > control its lifetime using your custom application.
> > > > > > >> > >
> > > > > > >> > > >
> > > > > > >> > > > 2) I am able to get a list of active traces lttng can
> see in
> > > > > > >> userspace, I
> > > > > > >> > > > enable all the traces and start tracing. The traces
> however
> > > > > seem to
> > > > > > >> not
> > > > > > >> > > be
> > > > > > >> > > > written anywhere on my filesystem. Do I have to specify
> a
> > > > > location?
> > > > > > >> Or
> > > > > > >> > > am I
> > > > > > >> > > > missing something? My current flow is:
> > > > > > >> > >
> > > > > > >> > > Please refer to the create command. If outputting locally
> you
> > > will
> > > > > > >> need to
> > > > > > >> > > pass
> > > > > > >> > > a "file://...." url to lttng_create_session.
> > > > > > >> > >
> > > > > > >> > > You can check on the result for each steps using "lttng
> list"
> > > and
> > > > > > >> "lttng
> > > > > > >> > > list
> > > > > > >> > > <session_name>" as you go to troubleshot your setup
> script.
> > > > > > >> > >
> > > > > > >> > > While debugging you can also start the lttng-sessiond in
> > > verbose
> > > > > mode
> > > > > > >> to
> > > > > > >> > > understand what is going on.
> > > > > > >> > >
> > > > > > >> > > Also note that you could also use the lttng "load" api if
> the
> > > > > session
> > > > > > >> you
> > > > > > >> > > are
> > > > > > >> > > trying to load is "static" and always the same. You would
> only
> > > > > need to
> > > > > > >> > > ship an
> > > > > > >> > > xml file with your application.
> > > > > > >> > >
> > > > > > >> > > Cheers
> > > > > > >> > >
> > > > > > >> > > >
> > > > > > >> > > >    - Creating a session
> > > > > > >> > > >    - Specifying the domain
> > > > > > >> > > >    - Creating a handle
> > > > > > >> > > >    - Creating a channel (with default attributes)
> > > > > > >> > > >    - Enabling the channel
> > > > > > >> > > >    - Enabling event (for all traces)
> > > > > > >> > > >    - Start tracing
> > > > > > >> > > >
> > > > > > >> > > > Thanks again for all the assistance.
> > > > > > >> > > >
> > > > > > >> > > > Regards,
> > > > > > >> > > > Mosleh
> > > > > > >> > > >
> > > > > > >> > > > On Tue, Mar 26, 2019 at 11:29 AM Jonathan
> Rajotte-Julien <
> > > > > > >> > > > jonathan.rajotte-julien@efficios.com> wrote:
> > > > > > >> > > >
> > > > > > >> > >
> > > > > > >>
> > > > > > >> --
> > > > > > >> Jonathan Rajotte-Julien
> > > > > > >> EfficiOS
> > > > > > >>
> > > > > > >
> > > > >
> > > > > --
> > > > > Jonathan Rajotte-Julien
> > > > > EfficiOS
> > > > >
> > >
> > > --
> > > Jonathan Rajotte-Julien
> > > EfficiOS
> > >
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--00000000000043a6530585a66731
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Apologies, did not mean for the message to be private.<div=
><br></div><div>Thank you for all your assistance, for now I think compilin=
g with the flag to disable cli is the way to go.</div><div><br></div><div>R=
egards,</div><div>Mosleh</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Apr 3, 2019 at 4:00 PM Jonathan Rajot=
te-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.com">jonat=
han.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Mosleh,<br>
<br>
I just saw this was a private email.<br>
<br>
As you will understand based on my previous email, this is slowly starting =
the<br>
be out of scope of our public support effort.<br>
<br>
Note that we do offer commercial support if it is something you would be<br=
>
interested in. You would be able to talk openly of the requirements, more<b=
r>
importantly of the project you are working on and how to integrate lttng wi=
th<br>
it.<br>
<br>
Cheers<br>
<br>
On Wed, Apr 03, 2019 at 02:15:55PM -0400, Mosleh Uddin wrote:<br>
&gt; I apologize, I will give the bigger picture of what I am trying to do.=
<br>
&gt; <br>
&gt; So the restraint I have is that I can&#39;t install lttng-tools and lt=
tng-ust<br>
&gt; libraries as part of the yocto build, mostly because we have release<b=
r>
&gt; software (for the public) and we don&#39;t want these CLI features ava=
ilable to<br>
&gt; the public (if they were to somehow access the CLI).<br>
&gt; <br>
&gt; I have compiled a userspace application using the &#39;lttng-ust&#39; =
compile flag<br>
&gt; with lttng tracepoints distributed throughout the code. I am creating =
a<br>
&gt; separate custom lttng application (compiled with lttng-ctl) which will=
<br>
&gt; communicate with the application (via domain socket) in order to dicta=
te<br>
&gt; when to start/stop sessions. I want the this custom application to hav=
e the<br>
&gt; ability to not only start/stop sessions but also spawn the session dae=
mon.<br>
&gt; <br>
&gt; From my description, you see that the system we are building for will =
not<br>
&gt; any have lttng libraries installed, I will be cross-compiling the<br>
&gt; applications with the libraries that are needed. I know you said lttng=
-ctl<br>
&gt; doesn&#39;t expose spawning sessiond, so I was curious how I could get=
 this<br>
&gt; functionality for my custom lttng application.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Mosleh<br>
&gt; <br>
&gt; On Wed, Apr 3, 2019 at 11:55 AM Jonathan Rajotte-Julien &lt;<br>
&gt; <a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_bla=
nk">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Wed, Apr 03, 2019 at 11:04:19AM -0400, Mosleh Uddin wrote:<br>
&gt; &gt; &gt; Hello,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; It is a limitation for both size and some security measures.=
 We want to<br>
&gt; &gt; &gt; ensure that we can set limits controlled by our custom appli=
cation.<br>
&gt; &gt;<br>
&gt; &gt; What security measure? What limits? Unless you provide clear requ=
irement<br>
&gt; &gt; it is<br>
&gt; &gt; quite hard to understand where you are going and how we can help =
you get<br>
&gt; &gt; there.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; For testing purposes, I did initially have lttng-tools and l=
ttng-ust<br>
&gt; &gt; added<br>
&gt; &gt; &gt; to the build image but again for the limitations described i=
t cannot go<br>
&gt; &gt; &gt; into the final &#39;production&#39; rootfs. So it&#39;s nice=
 that the service file<br>
&gt; &gt; &gt; exists, but without the tools installed I do not think I can=
 make use of<br>
&gt; &gt; &gt; it, unless there is a way to strip out everything from lttng=
-tools except<br>
&gt; &gt; &gt; for the sessiond functionality.<br>
&gt; &gt;<br>
&gt; &gt; Well the biggest part of lttng-tools project is lttng-sessiond an=
d<br>
&gt; &gt; lttng-consumerd. If the cli is the problem you can pass<br>
&gt; &gt; &quot;--disable-bin-lttng&quot; at<br>
&gt; &gt; configure time to simply exclude it from being built and installe=
d.<br>
&gt; &gt;<br>
&gt; &gt; As for lttng-sessiond executable, you can limit the user able to =
use it via<br>
&gt; &gt; regular user/group permissions.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; My guess from everything you are saying is that I will have =
to create a<br>
&gt; &gt; &gt; custom method for spawning a session daemon without having l=
ttng-tools<br>
&gt; &gt; &gt; available, however I am unsure where to start.<br>
&gt; &gt;<br>
&gt; &gt; No, you will need lttng-tools (in the sense of the project, no th=
e<br>
&gt; &gt; executable) to<br>
&gt; &gt; be present on the system if you want to trace at all.<br>
&gt; &gt;<br>
&gt; &gt; &gt; From way lttng-tools does<br>
&gt; &gt; &gt; it, I see it call the executable &#39;lttng-sessiond&#39;, b=
ut I cannot find a<br>
&gt; &gt; &gt; reference to when or how that executable is getting built.<b=
r>
&gt; &gt;<br>
&gt; &gt; Take a look at the src/bin folder (git tree). The &quot;lttng&quo=
t; subfolder is<br>
&gt; &gt; only the<br>
&gt; &gt; CLI. The meat of lttng is lttng-sessiond/relayd/consumerd.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks again for quick responses.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt; Mosleh<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Apr 3, 2019 at 10:25 AM Jonathan Rajotte-Julien &lt;=
<br>
&gt; &gt; &gt; <a href=3D"mailto:jonathan.rajotte-julien@efficios.com" targ=
et=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Wed, Apr 03, 2019 at 09:08:45AM -0400, Mosleh Uddin =
wrote:<br>
&gt; &gt; &gt; &gt; &gt; Hello,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Sorry, I should be more specific. I am creating a =
custom yocto<br>
&gt; &gt; build. I<br>
&gt; &gt; &gt; &gt; &gt; have seen some examples where systemd is utilized =
to start the<br>
&gt; &gt; sessiond<br>
&gt; &gt; &gt; &gt; as<br>
&gt; &gt; &gt; &gt; &gt; a service. The limitation I have is that I don&#39=
;t want to include the<br>
&gt; &gt; &gt; &gt; whole<br>
&gt; &gt; &gt; &gt; &gt; lttng-tools librray in my build. I understand that=
 the sessiond is an<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; You will have to if you plan on tracing any application=
s on your<br>
&gt; &gt; resulting<br>
&gt; &gt; &gt; &gt; image. Why is it a limitation? Size constraint?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; lttng-tools is already part of OE-core (the meta/ layer=
). Use this<br>
&gt; &gt; recipe<br>
&gt; &gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt; build it [1] or as a base for a custom one.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; [1]<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/m=
eta/recipes-kernel/lttng/lttng-tools_2.10.6.bb" rel=3D"noreferrer" target=
=3D"_blank">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/recip=
es-kernel/lttng/lttng-tools_2.10.6.bb</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; You can add the following to your local.conf file to bu=
ild only<br>
&gt; &gt; lttng-ust<br>
&gt; &gt; &gt; &gt; and<br>
&gt; &gt; &gt; &gt; lttng-tools.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; CORE_IMAGE_EXTRA_INSTALL +=3D &quot;lttng-ust lttng-too=
ls&quot;<br>
&gt; &gt; &gt; &gt; PACKAGECONFIG_pn-lttng-tools_append =3D &quot; lttng-us=
t&quot;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; By default a systemd service file is installed but is n=
ot activated<br>
&gt; &gt; (which<br>
&gt; &gt; &gt; &gt; seems<br>
&gt; &gt; &gt; &gt; to be what you want).<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Cheers<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; executable, I am just unsure how I could build or =
get this in my<br>
&gt; &gt; build.<br>
&gt; &gt; &gt; &gt; &gt; Moving forward from this I could use fork/exec to =
daemonize which<br>
&gt; &gt; would<br>
&gt; &gt; &gt; &gt; be<br>
&gt; &gt; &gt; &gt; &gt; simple.<br>
&gt; &gt; &gt; &gt; &gt; Is there perhaps a existing recipe?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt; &gt; &gt; Mosleh<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Tue, Apr 2, 2019 at 6:01 PM Mosleh Uddin &lt;<a=
 href=3D"mailto:mosleh1235@gmail.com" target=3D"_blank">mosleh1235@gmail.co=
m</a>&gt;<br>
&gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; That makes complete sense. I was more curious=
 about the sessiond<br>
&gt; &gt; &gt; &gt; &gt; &gt; executable. I&#39;m guessing this is somethin=
g I will have to create<br>
&gt; &gt; along<br>
&gt; &gt; &gt; &gt; with<br>
&gt; &gt; &gt; &gt; &gt; &gt; my build?<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt; &gt; &gt; &gt; Mosleh<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Tue, Apr 2, 2019 at 5:18 PM Jonathan Rajot=
te-Julien &lt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; <a href=3D"mailto:jonathan.rajotte-julien@eff=
icios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt; w=
rote:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; On Tue, Apr 02, 2019 at 04:54:00PM -0400,=
 Mosleh Uddin wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; Hello,<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; Could you give me some more insight =
into spawning my own<br>
&gt; &gt; sessiond?<br>
&gt; &gt; &gt; &gt; Sorry<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; I&#39;m not completely clear on the =
topic.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; Thank you for all your assistance.<b=
r>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; Normally lttng-sessiond is treated as a &=
quot;server/service/daemon&quot;<br>
&gt; &gt; (think<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; http<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; server as apache) and is *normally* launc=
hed as a daemon<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; (systemd/sysVinit) at<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; boot time.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; Managing manually the lifetime of a lttng=
-sessiond process is<br>
&gt; &gt; done the<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; same way<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; as any other process. You can manage it v=
ia the command line<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; (./lttng-sessiond), via a<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; service manager (systemd/upstart etc.) or=
 with a custom service<br>
&gt; &gt; &gt; &gt; manager (a<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; python script/c etc.).<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; You could spawn a lttng-sessiond from you=
r application with the<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; appropriate<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; parameters set to isolate it if you need.=
 LTTNG_HOME is an<br>
&gt; &gt; important<br>
&gt; &gt; &gt; &gt; one.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; The<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; output directory also can be manipulated.=
 See man lttng-sessiond<br>
&gt; &gt; for<br>
&gt; &gt; &gt; &gt; more<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; details. You will need to manage the proc=
ess or leave it to a<br>
&gt; &gt; system<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; administrator and only active tracing whe=
n a sessiond is present<br>
&gt; &gt; for<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; example.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; Cheers<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; Regards,<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; Mosleh<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; On Wed, Mar 27, 2019 at 1:52 PM Jona=
than Rajotte-Julien &lt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; <a href=3D"mailto:jonathan.rajotte-j=
ulien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.com<=
/a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; Hi Mosleh,<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; On Wed, Mar 27, 2019 at 12:09:5=
4PM -0400, Mosleh Uddin wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; Hello,<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; Thank you for the quick re=
sponse. I was able to use the<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; documentation you<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; provided to start a sessio=
n and get tracepoint list. I do<br>
&gt; &gt; have<br>
&gt; &gt; &gt; &gt; some<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; follow-up questions:<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; 1) I needed to create a se=
ssion daemon before executing my<br>
&gt; &gt; &gt; &gt; custom<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; application. In the API I =
did see functionality to see if a<br>
&gt; &gt; &gt; &gt; daemon<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; is<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; active, however, it is pos=
sible to spawn a session daemon<br>
&gt; &gt; in my<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; custom<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; app?<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; liblttng-ctl does not expose a =
lttng-sessiond spawning<br>
&gt; &gt; function<br>
&gt; &gt; &gt; &gt; since<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; by<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; definition it is a daemon execu=
table (think apache,mysql<br>
&gt; &gt; etc.),<br>
&gt; &gt; &gt; &gt; you<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; will<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; have to<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; use system/popen/exec.. to spaw=
n the lttng-sessiond process<br>
&gt; &gt; etc.<br>
&gt; &gt; &gt; &gt; if<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; you<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; want to<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; control its lifetime using your=
 custom application.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; 2) I am able to get a list=
 of active traces lttng can see in<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; userspace, I<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; enable all the traces and =
start tracing. The traces however<br>
&gt; &gt; &gt; &gt; seem to<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; not<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; be<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; written anywhere on my fil=
esystem. Do I have to specify a<br>
&gt; &gt; &gt; &gt; location?<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; Or<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; am I<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; missing something? My curr=
ent flow is:<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; Please refer to the create comm=
and. If outputting locally you<br>
&gt; &gt; will<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; need to<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; pass<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; a &quot;file://....&quot; url t=
o lttng_create_session.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; You can check on the result for=
 each steps using &quot;lttng list&quot;<br>
&gt; &gt; and<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &quot;lttng<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; list<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &lt;session_name&gt;&quot; as y=
ou go to troubleshot your setup script.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; While debugging you can also st=
art the lttng-sessiond in<br>
&gt; &gt; verbose<br>
&gt; &gt; &gt; &gt; mode<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; to<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; understand what is going on.<br=
>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; Also note that you could also u=
se the lttng &quot;load&quot; api if the<br>
&gt; &gt; &gt; &gt; session<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; you<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; are<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; trying to load is &quot;static&=
quot; and always the same. You would only<br>
&gt; &gt; &gt; &gt; need to<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; ship an<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; xml file with your application.=
<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; Cheers<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Creating a =
session<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Specifying =
the domain<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Creating a =
handle<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Creating a =
channel (with default attributes)<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Enabling th=
e channel<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Enabling ev=
ent (for all traces)<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 - Start traci=
ng<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; Thanks again for all the a=
ssistance.<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; Mosleh<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; On Tue, Mar 26, 2019 at 11=
:29 AM Jonathan Rajotte-Julien &lt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt; <a href=3D"mailto:jonathan=
.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@eff=
icios.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; --<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; Jonathan Rajotte-Julien<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt; EfficiOS<br>
&gt; &gt; &gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; Jonathan Rajotte-Julien<br>
&gt; &gt; &gt; &gt; EfficiOS<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Jonathan Rajotte-Julien<br>
&gt; &gt; EfficiOS<br>
&gt; &gt;<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--00000000000043a6530585a66731--

--===============8426252797376551026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8426252797376551026==--

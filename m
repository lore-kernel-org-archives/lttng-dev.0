From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Creating custom application
Date: Wed, 3 Apr 2019 11:55:31 -0400
Message-ID: <20190403155531.GA8451__42852.8074220353$1554306995$gmane$org@joraj-alpa>
References: <CAJyWpKHE_4eZwMAhU-q4sbAAA3-nPWgxtGqpXYLpMyztNzmm-w@mail.gmail.com>
 <20190326152942.GE17481@joraj-alpa>
 <CAJyWpKHtXHAgyjwZVnSCnnDTmCsOVsydaZgqpMuALQWMy5nfiA@mail.gmail.com>
 <20190327175251.GA7976@joraj-alpa>
 <CAJyWpKEhLdREuCFJEfSojHuqQ9jTA12SWE_FAJ3HTdP1irO-sw@mail.gmail.com>
 <20190402211757.GA23381@joraj-alpa>
 <CAJyWpKGDrF9J=yDALm+1cn7cTd+TJZK30tXLHKKKXvkntmQDoQ@mail.gmail.com>
 <CAJyWpKFxRqsVYc=dDvaoTMGkrkLmktaudYJgvVkzzvUyeFx-NQ@mail.gmail.com>
 <20190403142514.GB23381@joraj-alpa>
 <CAJyWpKGTZTKELQxb_XfnEhEjzMmSWe6oarR_XgS-9qmkoKfvNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Z9f240TNz1KFJ
 for <lttng-dev@lists.lttng.org>; Wed,  3 Apr 2019 11:55:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAJyWpKGTZTKELQxb_XfnEhEjzMmSWe6oarR_XgS-9qmkoKfvNA@mail.gmail.com>
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

On Wed, Apr 03, 2019 at 11:04:19AM -0400, Mosleh Uddin wrote:
> Hello,
> 
> It is a limitation for both size and some security measures. We want to
> ensure that we can set limits controlled by our custom application.

What security measure? What limits? Unless you provide clear requirement it is
quite hard to understand where you are going and how we can help you get there.

> 
> For testing purposes, I did initially have lttng-tools and lttng-ust added
> to the build image but again for the limitations described it cannot go
> into the final 'production' rootfs. So it's nice that the service file
> exists, but without the tools installed I do not think I can make use of
> it, unless there is a way to strip out everything from lttng-tools except
> for the sessiond functionality.

Well the biggest part of lttng-tools project is lttng-sessiond and
lttng-consumerd. If the cli is the problem you can pass "--disable-bin-lttng" at
configure time to simply exclude it from being built and installed.

As for lttng-sessiond executable, you can limit the user able to use it via
regular user/group permissions.

> 
> My guess from everything you are saying is that I will have to create a
> custom method for spawning a session daemon without having lttng-tools
> available, however I am unsure where to start.

No, you will need lttng-tools (in the sense of the project, no the executable) to
be present on the system if you want to trace at all.

> From way lttng-tools does
> it, I see it call the executable 'lttng-sessiond', but I cannot find a
> reference to when or how that executable is getting built.

Take a look at the src/bin folder (git tree). The "lttng" subfolder is only the
CLI. The meat of lttng is lttng-sessiond/relayd/consumerd.

> 
> Thanks again for quick responses.
> 
> Regards,
> Mosleh
> 
> 
> 
> On Wed, Apr 3, 2019 at 10:25 AM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
> 
> > On Wed, Apr 03, 2019 at 09:08:45AM -0400, Mosleh Uddin wrote:
> > > Hello,
> > >
> > > Sorry, I should be more specific. I am creating a custom yocto build. I
> > > have seen some examples where systemd is utilized to start the sessiond
> > as
> > > a service. The limitation I have is that I don't want to include the
> > whole
> > > lttng-tools librray in my build. I understand that the sessiond is an
> >
> > You will have to if you plan on tracing any applications on your resulting
> > image. Why is it a limitation? Size constraint?
> >
> > lttng-tools is already part of OE-core (the meta/ layer). Use this recipe
> > to
> > build it [1] or as a base for a custom one.
> >
> > [1]
> > https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/recipes-kernel/lttng/lttng-tools_2.10.6.bb
> >
> > You can add the following to your local.conf file to build only lttng-ust
> > and
> > lttng-tools.
> >
> > CORE_IMAGE_EXTRA_INSTALL += "lttng-ust lttng-tools"
> > PACKAGECONFIG_pn-lttng-tools_append = " lttng-ust"
> >
> > By default a systemd service file is installed but is not activated (which
> > seems
> > to be what you want).
> >
> > Cheers
> >
> >
> > > executable, I am just unsure how I could build or get this in my build.
> > > Moving forward from this I could use fork/exec to daemonize which would
> > be
> > > simple.
> > > Is there perhaps a existing recipe?
> > >
> > > Regards,
> > > Mosleh
> > >
> > > On Tue, Apr 2, 2019 at 6:01 PM Mosleh Uddin <mosleh1235@gmail.com>
> > wrote:
> > >
> > > > Hi,
> > > >
> > > > That makes complete sense. I was more curious about the sessiond
> > > > executable. I'm guessing this is something I will have to create along
> > with
> > > > my build?
> > > >
> > > > Regards,
> > > > Mosleh
> > > >
> > > > On Tue, Apr 2, 2019 at 5:18 PM Jonathan Rajotte-Julien <
> > > > jonathan.rajotte-julien@efficios.com> wrote:
> > > >
> > > >> On Tue, Apr 02, 2019 at 04:54:00PM -0400, Mosleh Uddin wrote:
> > > >> > Hello,
> > > >> >
> > > >> > Could you give me some more insight into spawning my own sessiond?
> > Sorry
> > > >> > I'm not completely clear on the topic.
> > > >> > Thank you for all your assistance.
> > > >>
> > > >> Normally lttng-sessiond is treated as a "server/service/daemon" (think
> > > >> http
> > > >> server as apache) and is *normally* launched as a daemon
> > > >> (systemd/sysVinit) at
> > > >> boot time.
> > > >>
> > > >> Managing manually the lifetime of a lttng-sessiond process is done the
> > > >> same way
> > > >> as any other process. You can manage it via the command line
> > > >> (./lttng-sessiond), via a
> > > >> service manager (systemd/upstart etc.) or with a custom service
> > manager (a
> > > >> python script/c etc.).
> > > >>
> > > >> You could spawn a lttng-sessiond from your application with the
> > > >> appropriate
> > > >> parameters set to isolate it if you need. LTTNG_HOME is an important
> > one.
> > > >> The
> > > >> output directory also can be manipulated. See man lttng-sessiond for
> > more
> > > >> details. You will need to manage the process or leave it to a system
> > > >> administrator and only active tracing when a sessiond is present for
> > > >> example.
> > > >>
> > > >> Cheers
> > > >>
> > > >> >
> > > >> > Regards,
> > > >> > Mosleh
> > > >> >
> > > >> > On Wed, Mar 27, 2019 at 1:52 PM Jonathan Rajotte-Julien <
> > > >> > jonathan.rajotte-julien@efficios.com> wrote:
> > > >> >
> > > >> > > Hi Mosleh,
> > > >> > >
> > > >> > > On Wed, Mar 27, 2019 at 12:09:54PM -0400, Mosleh Uddin wrote:
> > > >> > > > Hello,
> > > >> > > >
> > > >> > > > Thank you for the quick response. I was able to use the
> > > >> documentation you
> > > >> > > > provided to start a session and get tracepoint list. I do have
> > some
> > > >> > > > follow-up questions:
> > > >> > > >
> > > >> > > > 1) I needed to create a session daemon before executing my
> > custom
> > > >> > > > application. In the API I did see functionality to see if a
> > daemon
> > > >> is
> > > >> > > > active, however, it is possible to spawn a session daemon in my
> > > >> custom
> > > >> > > app?
> > > >> > >
> > > >> > > liblttng-ctl does not expose a lttng-sessiond spawning function
> > since
> > > >> by
> > > >> > > definition it is a daemon executable (think apache,mysql etc.),
> > you
> > > >> will
> > > >> > > have to
> > > >> > > use system/popen/exec.. to spawn the lttng-sessiond process etc.
> > if
> > > >> you
> > > >> > > want to
> > > >> > > control its lifetime using your custom application.
> > > >> > >
> > > >> > > >
> > > >> > > > 2) I am able to get a list of active traces lttng can see in
> > > >> userspace, I
> > > >> > > > enable all the traces and start tracing. The traces however
> > seem to
> > > >> not
> > > >> > > be
> > > >> > > > written anywhere on my filesystem. Do I have to specify a
> > location?
> > > >> Or
> > > >> > > am I
> > > >> > > > missing something? My current flow is:
> > > >> > >
> > > >> > > Please refer to the create command. If outputting locally you will
> > > >> need to
> > > >> > > pass
> > > >> > > a "file://...." url to lttng_create_session.
> > > >> > >
> > > >> > > You can check on the result for each steps using "lttng list" and
> > > >> "lttng
> > > >> > > list
> > > >> > > <session_name>" as you go to troubleshot your setup script.
> > > >> > >
> > > >> > > While debugging you can also start the lttng-sessiond in verbose
> > mode
> > > >> to
> > > >> > > understand what is going on.
> > > >> > >
> > > >> > > Also note that you could also use the lttng "load" api if the
> > session
> > > >> you
> > > >> > > are
> > > >> > > trying to load is "static" and always the same. You would only
> > need to
> > > >> > > ship an
> > > >> > > xml file with your application.
> > > >> > >
> > > >> > > Cheers
> > > >> > >
> > > >> > > >
> > > >> > > >    - Creating a session
> > > >> > > >    - Specifying the domain
> > > >> > > >    - Creating a handle
> > > >> > > >    - Creating a channel (with default attributes)
> > > >> > > >    - Enabling the channel
> > > >> > > >    - Enabling event (for all traces)
> > > >> > > >    - Start tracing
> > > >> > > >
> > > >> > > > Thanks again for all the assistance.
> > > >> > > >
> > > >> > > > Regards,
> > > >> > > > Mosleh
> > > >> > > >
> > > >> > > > On Tue, Mar 26, 2019 at 11:29 AM Jonathan Rajotte-Julien <
> > > >> > > > jonathan.rajotte-julien@efficios.com> wrote:
> > > >> > > >
> > > >> > >
> > > >>
> > > >> --
> > > >> Jonathan Rajotte-Julien
> > > >> EfficiOS
> > > >>
> > > >
> >
> > --
> > Jonathan Rajotte-Julien
> > EfficiOS
> >

-- 
Jonathan Rajotte-Julien
EfficiOS

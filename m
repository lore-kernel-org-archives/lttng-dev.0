From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Creating custom application
Date: Tue, 2 Apr 2019 17:18:06 -0400
Message-ID: <20190402211757.GA23381__31798.5675575741$1554239916$gmane$org@joraj-alpa>
References: <CAJyWpKHE_4eZwMAhU-q4sbAAA3-nPWgxtGqpXYLpMyztNzmm-w@mail.gmail.com>
 <20190326152942.GE17481@joraj-alpa>
 <CAJyWpKHtXHAgyjwZVnSCnnDTmCsOVsydaZgqpMuALQWMy5nfiA@mail.gmail.com>
 <20190327175251.GA7976@joraj-alpa>
 <CAJyWpKEhLdREuCFJEfSojHuqQ9jTA12SWE_FAJ3HTdP1irO-sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Yhrp5wxSz17bK
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2019 17:18:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAJyWpKEhLdREuCFJEfSojHuqQ9jTA12SWE_FAJ3HTdP1irO-sw@mail.gmail.com>
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

On Tue, Apr 02, 2019 at 04:54:00PM -0400, Mosleh Uddin wrote:
> Hello,
> 
> Could you give me some more insight into spawning my own sessiond? Sorry
> I'm not completely clear on the topic.
> Thank you for all your assistance.

Normally lttng-sessiond is treated as a "server/service/daemon" (think http
server as apache) and is *normally* launched as a daemon (systemd/sysVinit) at
boot time.

Managing manually the lifetime of a lttng-sessiond process is done the same way
as any other process. You can manage it via the command line (./lttng-sessiond), via a
service manager (systemd/upstart etc.) or with a custom service manager (a
python script/c etc.).

You could spawn a lttng-sessiond from your application with the appropriate
parameters set to isolate it if you need. LTTNG_HOME is an important one. The
output directory also can be manipulated. See man lttng-sessiond for more
details. You will need to manage the process or leave it to a system
administrator and only active tracing when a sessiond is present for example.

Cheers

> 
> Regards,
> Mosleh
> 
> On Wed, Mar 27, 2019 at 1:52 PM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
> 
> > Hi Mosleh,
> >
> > On Wed, Mar 27, 2019 at 12:09:54PM -0400, Mosleh Uddin wrote:
> > > Hello,
> > >
> > > Thank you for the quick response. I was able to use the documentation you
> > > provided to start a session and get tracepoint list. I do have some
> > > follow-up questions:
> > >
> > > 1) I needed to create a session daemon before executing my custom
> > > application. In the API I did see functionality to see if a daemon is
> > > active, however, it is possible to spawn a session daemon in my custom
> > app?
> >
> > liblttng-ctl does not expose a lttng-sessiond spawning function since by
> > definition it is a daemon executable (think apache,mysql etc.), you will
> > have to
> > use system/popen/exec.. to spawn the lttng-sessiond process etc. if you
> > want to
> > control its lifetime using your custom application.
> >
> > >
> > > 2) I am able to get a list of active traces lttng can see in userspace, I
> > > enable all the traces and start tracing. The traces however seem to not
> > be
> > > written anywhere on my filesystem. Do I have to specify a location? Or
> > am I
> > > missing something? My current flow is:
> >
> > Please refer to the create command. If outputting locally you will need to
> > pass
> > a "file://...." url to lttng_create_session.
> >
> > You can check on the result for each steps using "lttng list" and "lttng
> > list
> > <session_name>" as you go to troubleshot your setup script.
> >
> > While debugging you can also start the lttng-sessiond in verbose mode to
> > understand what is going on.
> >
> > Also note that you could also use the lttng "load" api if the session you
> > are
> > trying to load is "static" and always the same. You would only need to
> > ship an
> > xml file with your application.
> >
> > Cheers
> >
> > >
> > >    - Creating a session
> > >    - Specifying the domain
> > >    - Creating a handle
> > >    - Creating a channel (with default attributes)
> > >    - Enabling the channel
> > >    - Enabling event (for all traces)
> > >    - Start tracing
> > >
> > > Thanks again for all the assistance.
> > >
> > > Regards,
> > > Mosleh
> > >
> > > On Tue, Mar 26, 2019 at 11:29 AM Jonathan Rajotte-Julien <
> > > jonathan.rajotte-julien@efficios.com> wrote:
> > >
> >

-- 
Jonathan Rajotte-Julien
EfficiOS

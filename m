From: Jon Bernard <jbernard@debian.org>
Subject: Re: babeltrace test failures on some architectures
Date: Mon, 9 Jun 2014 10:52:01 -0400
Message-ID: <20140609145201.GB25766__6369.71468707106$1402325592$gmane$org@helmut>
References: <20140604184126.GA26877@helmut>
 <CA+jJMxtn8XiLjT5NVURv5K8kECPPoPs1WF-0zTakJmRW=CO3mg@mail.gmail.com>
 <CAEzWAeLEvv8FbHfwq8=sMeDW49DjO_gKoZ99z1Ff9s+dR6GuJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1Wu0vf-0000kW-Rf
 for lttng-dev@lists.lttng.org; Mon, 09 Jun 2014 10:52:13 -0400
Content-Disposition: inline
In-Reply-To: <CAEzWAeLEvv8FbHfwq8=sMeDW49DjO_gKoZ99z1Ff9s+dR6GuJQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Brosseau, Yannick <yannick.brosseau@gmail.com> wrote:
> J=E9r=E9mie, the end of the build.log seem to contains the tests output.

If I can provide additional info that isn't in the logs, or run
specialized tests, etc, just let me know.

-- =

Jon

> On Mon, Jun 9, 2014 at 10:16 AM, J=E9r=E9mie Galarneau <
> jeremie.galarneau@efficios.com> wrote:
> =

> > Hi Jon,
> >
> > Would it be possible to run the tests on these machines and provide
> > the TAP output?
> >
> > Thanks,
> > J=E9r=E9mie
> >
> > On Wed, Jun 4, 2014 at 2:41 PM, Jon Bernard <jbernard@debian.org> wrote:
> > > I noticed babeltrace is having test failures on armel, hurd-i386,
> > > kfreebsd-{amd64,i386}, and sparc.  These were passing in version 1.1 =
and
> > > the failures appeared in 1.2.  Here are links to the build logs:
> > >
> > >     armel:
> > https://buildd.debian.org/status/fetch.php?pkg=3Dbabeltrace&arch=3Darme=
l&ver=3D1.2.1-2&stamp=3D1395846913
> > >     hurd-i386:
> > https://buildd.debian.org/status/fetch.php?pkg=3Dbabeltrace&arch=3Dhurd=
-i386&ver=3D1.2.1-2&stamp=3D1398158394
> > >     kfreebsd-amd64:
> > https://buildd.debian.org/status/architecture.php?a=3Dkfreebsd-amd64&su=
ite=3Dsid
> > >     kfreebsd-i386:
> > https://buildd.debian.org/status/fetch.php?pkg=3Dbabeltrace&arch=3Dkfre=
ebsd-i386&ver=3D1.2.1-2&stamp=3D1395842518
> > >     sparc:
> > https://buildd.debian.org/status/fetch.php?pkg=3Dbabeltrace&arch=3Dspar=
c&ver=3D1.2.1-2&stamp=3D1395859546
> > >
> > >     buildd page:
> > https://buildd.debian.org/status/package.php?p=3Dbabeltrace
> > >
> > > Cheers,
> > >
> > > --
> > > Jon
> > >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> >
> > --
> > J=E9r=E9mie Galarneau
> > EfficiOS Inc.
> > http://www.efficios.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >

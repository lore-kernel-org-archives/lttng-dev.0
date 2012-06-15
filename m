From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng - ubuntu 11.10 - problem
Date: Fri, 15 Jun 2012 11:12:34 -0400
Message-ID: <20120615151234.GA28295__21906.6621074036$1339773185$gmane$org@Krystal>
References: <1339746088.90723.YahooMailNeo@web161201.mail.bf1.yahoo.com>
	<4FDAEF5C.9030102@gmail.com> <4FDB34C8.7000505@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SfYCR-0001Yg-Gb
	for lttng-dev@lists.lttng.org; Fri, 15 Jun 2012 11:12:35 -0400
Content-Disposition: inline
In-Reply-To: <4FDB34C8.7000505@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <david.goulet@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* David Goulet (david.goulet@polymtl.ca) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> =

> Hi,
> =

> In order to trace the kernel, you need the LTTng kernel modules available=
 in
> the package "lttng-modules-dkms". So make sure you have these three packa=
ges
> installed:
> =

> # sudo apt-get install lttng-tools lttng-modules-dkms babeltrace

hopefully lttng-modules-dkms issues "depmod -a" after the make
modules_install ?

Mathieu

> =

> The error message you got indicates that there is simply no LTTng modules
> loaded. Please make sure they are loaded and if the problem persist, let =
us know!
> =

> Thanks!
> David
> =

> On 15/06/12 04:16 AM, Francis Giraldeau wrote:
> > Le 2012-06-15 09:41, somanath sahoo a =E9crit :
> >> Hi,
> >> =

> >> As i am new to lttng usage, I have followed the instructions from =

> >> <https://launchpad.net/~lttng/+archive/ppa> in order to install the lt=
tng
> >> tool set in my ubuntu 11.10. After successful installation, i followed
> >> the getting started link on lttng.org <http://lttng.org/quickstart> in
> >> "root mode".
> > =

> > You may verify if kernel modules are loaded correctly. If not, then the=
re
> > may be a problem while the installation.
> > =

> > lsmod | grep lttng
> > =

> > If not, you may try to load them and see if any error message occurs:
> > =

> > sudo modprobe lttng_tracer
> > =

> > Francis
> > =

> > =

> > =

> > _______________________________________________ lttng-dev mailing list =

> > lttng-dev@lists.lttng.org =

> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
> =

> iQEcBAEBAgAGBQJP2zTIAAoJEELoaioR9I02CVEH/1ripsIVxDQ2JRPNXs0TVWLD
> 5B/qf3oKTohuKCoKE7Q7ZLyo1A9WN0z9JFouVecEPD7MisdJqYufEXkUNbxHg2+y
> 9nVT8xF7gToLRBi/qC/hH0JN6AADJmqTVxYAvygv8qWNkLR3PSqguDhE5nM9vrtF
> LJSEYlYQh0dktkBM9ESm0lrnbZO/AtXxQB4IbCQSwP1tsNmftEdZ24H8DN0/QWl9
> niRT6XpBzogNJfQQOPFtJTFxpwKHiMQXdE78UtzzMBPZ9P57Go9jMgP+2FELFZl4
> wcu+XMIF2Gx81AajfTkGAjPOczagqKzrgnMCduQaNgCI1hRoWOn7Yu1jTmA6Yxc=3D
> =3Doy1n
> -----END PGP SIGNATURE-----
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com

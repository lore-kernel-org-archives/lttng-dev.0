From: David Goulet <dgoulet@efficios.com>
Subject: Re: error in generation of trace files
Date: Thu, 27 Feb 2014 08:57:48 -0500
Message-ID: <20140227135748.GB7407__22229.9623339952$1393509544$gmane$org@thessa>
References: <CAB7sTjgY9OpaQG-Cs2gnHA6s3+hHuutkP=6wPPVq5TkfdY-hng@mail.gmail.com>
	<20140227134247.GA7407@thessa>
	<CAB7sTjjHMizJVJOYCpqED=rzt=+KJB_2Nxjf7X2C2y2+G=E_sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0554004484=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WJ1TJ-0006g1-Gc
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 08:58:03 -0500
In-Reply-To: <CAB7sTjjHMizJVJOYCpqED=rzt=+KJB_2Nxjf7X2C2y2+G=E_sA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mariya Rampurawala <mariya.r26@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0554004484==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27 Feb (19:22:35), Mariya Rampurawala wrote:
> Thank you for the reply.
> So the following commands i run on my terminal:
>=20
> mariya@HP:~$ lttng create mysession
> Session mysession created.
> Traces will be written in
> /home/mariya/lttng-traces/mysession-20140227-191901
> mariya@HP:~$ lttng enable-event -a -u
> All UST events are enabled in channel channel0

CCing back lttng-dev ML. If you have this problem, others have! :)

Ok so this means that you enable all user space event for that session
so you need to have an application that is instrumented with LTTng
userspace tracer (lttng-ust) in order to collect data from that app.
There are multiple examples in the git repository.

For the kernel (-a -k), you need to install lttng-modules and start
lttng-sessiond as root (or set yourself in the "tracing" group).

Hope this help!

Cheers!
David

> mariya@HP:~$ lttng start
> Tracing started for session mysession
> mariya@HP:~$ lttng stop
> Waiting for data availability
> Tracing stopped for session mysession
> mariya@HP:~$ lttng view
> Trace directory: /home/mariya/lttng-traces/mysession-20140227-191901
>=20
> [error] Cannot open any trace for reading.
>=20
> [error] opening trace "/home/mariya/lttng-traces/mysession-20140227-19190=
1"
> for reading.
>=20
> [error] none of the specified trace paths could be opened.
>=20
> mariya@HP:~$ lttng-sessiond -vvv
> DEBUG3: Creating LTTng run directory: /home/mariya/.lttng [in
> create_lttng_rundir() at main.c:3692]
> DEBUG1: Client socket path /home/mariya/.lttng/client-lttng-sessiond [in
> main() at main.c:3995]
> DEBUG1: Application socket path /home/mariya/.lttng/apps-lttng-sessiond [=
in
> main() at main.c:3996]
> DEBUG1: LTTng run directory path: /home/mariya/.lttng [in main() at
> main.c:3997]
> DEBUG2: UST consumer 32 bits err path:
> /home/mariya/.lttng/ustconsumerd32/error [in main() at main.c:4006]
> DEBUG2: UST consumer 32 bits cmd path:
> /home/mariya/.lttng/ustconsumerd32/command [in main() at main.c:4008]
> DEBUG2: UST consumer 64 bits err path:
> /home/mariya/.lttng/ustconsumerd64/error [in main() at main.c:4017]
> DEBUG2: UST consumer 64 bits cmd path:
> /home/mariya/.lttng/ustconsumerd64/command [in main() at main.c:4019]
> Error: Already running daemon.
>=20
>=20
>=20
> On Thu, Feb 27, 2014 at 7:12 PM, David Goulet <dgoulet@efficios.com> wrot=
e:
>=20
> > On 27 Feb (16:36:24), Mariya Rampurawala wrote:
> > > Hello,
> > >  I'm new to lttng. I use ubuntu 13.10. While performing basic operati=
ons,
> > > on command lttng view, i get the following error.
> > > [error] Cannot open any trace for reading.
> > >
> > > [error] opening trace
> > "/home/mariya/lttng-traces/mysession-20140227-163353"
> > > for reading.
> > >
> > > [error] none of the specified trace paths could be opened.
> > >
> > >
> > > the o/p of the command "lttng-sessiond --verbose" is as follows
> > >
> > > DEBUG3: Creating LTTng run directory: /home/mariya/.lttng [in
> > > create_lttng_rundir() at main.c:3692]
> > > DEBUG1: Client socket path /home/mariya/.lttng/client-lttng-sessiond =
[in
> > > main() at main.c:3995]
> > > DEBUG1: Application socket path /home/mariya/.lttng/apps-lttng-sessio=
nd
> > [in
> > > main() at main.c:3996]
> > > DEBUG1: LTTng run directory path: /home/mariya/.lttng [in main() at
> > > main.c:3997]
> > > Error: Already running daemon.
> > >
> > > Could you please help me solve the error and proceed with my project?
> >
> > Hi,
> >
> > So like the error says, you have an already dunnring daemon but that
> > shouldn't stop you from tracing stuff.
> >
> > Can you provide step by step the command you did and from there we can
> > help you out more easily. The -vvv to the session daemon are good
> > information to have also!
> >
> > Thanks!
> > David
> >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTD0RcXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02UhQH/RAZLqx7xLvbOl23eFBZDalT
5kudQGXI6+oZYmIUT7cJUsZBxkojC9VYp+7AI3nM1/UG7CdM33ttCIRha1820G6D
Wer7UbbAnSr607mkYvUiCphcDjqDxKAHLFbQVajok3NLGh140g+CfRIT6WFr5zTa
E7wOLtAUId3Tjk/0eBF6pyXsU5nnL/8LveuPr8kDPFGiWeIQcDyZFdGTKTwKUTfk
pGHYIZAJE8TY+xapT6k9qaI6JRoPNRFi48G1LXlHgnFh/6mU5sYIfJCdPztPR9v3
ds/kw0QppLiUvTKqWC43PnJzeRgBOY1Jd9rnKXiiheuhlOW7C7aXZMxLkuh+/bM=
=Az0e
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--


--===============0554004484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0554004484==--

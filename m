From: David Goulet <dgoulet@efficios.com>
Subject: Re: lttng-tools build error: non-dynamic relocations
 refer to dynamic symbol lttcomm_inet_tcp_timeout
Date: Thu, 28 Nov 2013 15:32:43 -0500
Message-ID: <20131128203243.GC8372__16974.4598017589$1385670838$gmane$org@thessa>
References: <CAO_ArvpzYu+bVKKi956eiObSd+sg-6Aarhy+h5MZqcDk5S-eqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1554445460=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Vm8GZ-0005DO-NG
	for lttng-dev@lists.lttng.org; Thu, 28 Nov 2013 15:32:58 -0500
In-Reply-To: <CAO_ArvpzYu+bVKKi956eiObSd+sg-6Aarhy+h5MZqcDk5S-eqg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: kumar s <skumar.m226@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1554445460==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27 Nov (15:37:10), kumar s wrote:
> Hi,
>=20
> I am getting non dynamic relocation error while trying to build
> lttng-tools. I have configured the lttng-tools for mips-gcc.
>=20
> Making all in lttng-sessiond
> make[3]: Entering directory
> `/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-sessiond'
>   CC     utils.o
>   CC     trace-kernel.o
>   CC     kernel.o
>   CC     context.o
>   CC     channel.o
>   CC     event.o
>   CC     shm.o
>   CC     consumer.o
>   CC     session.o
>   CC     modprobe.o
>   CC     fd-limit.o
>   CC     kernel-consumer.o
>   CC     cmd.o
>   CC     buffer-registry.o
>   CC     ht-cleanup.o
>   CC     snapshot.o
>   CC     jul.o
>   CC     main.o
> main.c: In function 'thread_dispatch_ust_registration':
> main.c:1564: warning: 'cds_wfq_dequeue_blocking' is deprecated (declared =
at
> /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/include/u=
rcu/wfqueue.h:88)
> main.c: In function 'thread_registration_apps':
> main.c:1917: warning: 'cds_wfq_enqueue' is deprecated (declared at
> /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/include/u=
rcu/wfqueue.h:76)
> main.c: In function 'main':
> main.c:4891: warning: 'cds_wfq_init' is deprecated (declared at
> /home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/include/u=
rcu/wfqueue.h:70)
>   CCLD   lttng-sessiond
> /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/t=
ools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mips6=
4-octeon-linux-gnu/bin/ld:
> non-dynamic relocations refer to dynamic symbol lttcomm_inet_tcp_timeout
> /home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/t=
ools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mips6=
4-octeon-linux-gnu/bin/ld:
> failed to set dynamic section sizes: Bad value

Looks quite the same here:
https://sourceware.org/bugzilla/show_bug.cgi?id=3D10144#c8

It seems that this is a gcc bug with -g. I'm not too familiar with MIPS
but you could try removing the -g or using "-mplt" as stated in the bug.

Cheers!
David

> collect2: ld returned 1 exit status
> make[3]: *** [lttng-sessiond] Error 1
> make[3]: Leaving directory
> `/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-sessiond'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/bin'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src'
> make: *** [all-recursive] Error 1
>=20
> Thank you
> Skumar

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSl6hqXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02LUcIAJVopi0arP9KF8H03sWWk+kV
AbH6Oihc+SMBatx0H36zCRcTOjFb5GL9riYzIVVyClvEqW9DaQw27fig1e17xBFu
5eB4T+BuaFywMxcGwxcd6aZ+ESgLQR/5M6PO8wJCktNB4gAJz66doLFxjcdJywfG
N6VJWJ1cRm+5g0EP03VAjUXmtuTtQO+3dwMAmUEfzn5OnqtOPG8rn28ACuAkzQ/F
MdcAbHV266AUQeNR+c6peG/jlWQbt0MeFYKUrEhkDURrJJgiBAD2+t7AJqvldgUd
4vGdMpbUYOzmiiPkWduyRUEr5PrvQJuvJ0R29QjTir4F5E1NtUvl6NMC3cTUo7I=
=8c31
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--


--===============1554445460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1554445460==--

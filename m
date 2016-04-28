From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: Question about lock in synchronize_rcu
 implementation of URCU
Date: Thu, 28 Apr 2016 20:44:01 +0800
Message-ID: <20160428124401.GB25392__4155.98252225227$1461847292$gmane$org@insomnia>
References: <CAAKbDrfmcqEE7_6p_J0DPVO85yDGJ0GCbi5k9Lm19g4VaLgOWw@mail.gmail.com>
 <20160428020803.GN4967@linux.vnet.ibm.com>
 <CAAKbDrfRMKzu6brHG=pfm0mu_Oy1afVZ94zDCiN7Y0w5o+SMZQ@mail.gmail.com>
 <20160428042327.GP4967@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7236659815749838430=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
 [209.85.213.178])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 99D8FA08BC
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 12:40:58 +0000 (UTC)
Received: by mail-ig0-f178.google.com with SMTP id s8so19514746ign.0
 for <lttng-dev@lists.lttng.org>; Thu, 28 Apr 2016 05:40:58 -0700 (PDT)
In-Reply-To: <20160428042327.GP4967@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============7236659815749838430==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul and Yuxin,

On Wed, Apr 27, 2016 at 09:23:27PM -0700, Paul E. McKenney wrote:
> Try building without it and see what happens when you run the tests.
>=20

I've run a 'regtest' with the following modification out of curiousity:

diff --git a/urcu.c b/urcu.c
index a5568bdbd075..9dc3c9feae56 100644
--- a/urcu.c
+++ b/urcu.c
@@ -398,8 +398,6 @@ void synchronize_rcu(void)
 	/* We won't need to wake ourself up */
 	urcu_wait_set_state(&wait, URCU_WAIT_RUNNING);
=20
-	mutex_lock(&rcu_gp_lock);
-
 	/*
 	 * Move all waiters into our local queue.
 	 */
@@ -480,7 +478,6 @@ void synchronize_rcu(void)
 	smp_mb_master();
 out:
 	mutex_unlock(&rcu_registry_lock);
-	mutex_unlock(&rcu_gp_lock);
=20
 	/*
 	 * Wakeup waiters only after we have completed the grace period


And guess what, the result of the test was:

Test Summary Report
-------------------
=2E/run-urcu-tests.sh 1 (Wstat: 0 Tests: 979 Failed: 18)
  Failed tests:  30, 45, 60, 75, 90, 103, 105, 120, 135
                  150, 165, 180, 195, 210, 225, 240, 253
		  255
Files=3D2, Tests=3D996, 1039 wallclock secs ( 0.55 usr  0.04 sys + 8981.02 =
cusr 597.64 csys =3D 9579.25 CPU)
Result: FAIL

And test case 30 for example is something like:

tests/benchmark/test_urcu_mb <nreaders> <nwriters> 1 -d 0 -b 32768

and it failed because:

lt-test_urcu_mb: test_urcu.c:183: thr_reader: Assertion `*local_ptr =3D=3D =
8' failed.
zsh: abort (core dumped)  ~/userspace-rcu/tests/benchmark/test_urcu_mb 4 4 =
1 -d 0 -b 32768

So I think what was going on here was:

CPU 0 (reader)			CPU 1 (writer)					CPU 2 (writer)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D				=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
rcu_read_lock();								new =3D malloc(sizeof(int));
local_ptr =3D rcu_dereference(test_rcu_pointer); // local_ptr =3D=3D old		*=
new =3D 8;
										old =3D rcu_xchg_pointer(&test_rcu_pointer, new);
				synchronize_rcu():
				  urcu_wait_add(); // return 0
				  urcu_move_waiters(); // @gp_waiters is empty,
				  		       // the next urcu_wait_add() will return 0

				  						synchronize_rcu():
									  	  urcu_wait_add(); // return 0

				  mutex_lock(&rcu_register_lock);
				  wait_for_readers(); // remove registered reader from @registery,
				  		      // release rcu_register_lock and wait via poll()

										  mutex_lock(&rcu_registry_lock);
										  wait_for_readers(); // @regsitery is empty! we are so lucky
										  return;

										if (old)
											free(old)
rcu_read_unlock();
assert(*local_ptr=3D=3D8); // but local_ptr(i.e. old) is already freed.


So the point is there could be two writers calling synchronize_rcu() but
not returning early(both of them enter the slow path to perform a grace
period), so the rcu_gp_lock is necessary in this case.

(Cc  Mathieu)

But this is only my understanding and I'm learning the URCU code too ;-)

Regards,
Boqun


> Might well be that it is unnecessary, but I will defer to Mathieu
> on that point.
>=20
> 							Thanx, Paul
>=20
> On Wed, Apr 27, 2016 at 10:18:04PM -0400, Yuxin Ren wrote:
> > As they don't currently perform grace period, why do we use the rcu_gp_=
lock?
> >=20
> > Thank you.
> > Yuxin
> >=20
> > On Wed, Apr 27, 2016 at 10:08 PM, Paul E. McKenney
> > <paulmck@linux.vnet.ibm.com> wrote:
> > > On Wed, Apr 27, 2016 at 09:34:16PM -0400, Yuxin Ren wrote:
> > >> Hi,
> > >>
> > >> I am learning the URCU code.
> > >>
> > >> Why do we need rcu_gp_lock in synchronize_rcu?
> > >> https://github.com/urcu/userspace-rcu/blob/master/urcu.c#L401
> > >>
> > >> In the comment, it says this lock ensures mutual exclusion between
> > >> threads calling synchronize_rcu().
> > >> But only the first thread added to waiter queue can proceed to detect
> > >> grace period.
> > >> How can multiple threads currently perform the grace thread?
> > >
> > > They don't concurrently perform grace periods, and it would be wastef=
ul
> > > for them to do so.  Instead, the first one performs the grace period,
> > > and all that were waiting at the time it started get the benefit of t=
hat
> > > same grace period.
> > >
> > > Any that arrived after the first grace period performs the first
> > > grace period are served by whichever of them performs the second
> > > grace period.
> > >
> > >                                                         Thanx, Paul
> > >
> >=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXIgWLAAoJEEl56MO1B/q4gHIIAJYniLkkEoJd1W8XZI16lEDN
845ft9DzMYZyE7kjwmFb79PztPURkb9oPa58ODYl/v19SRDcIl2dciMNn5N8pSJr
0Ki4c9aeDjdN5+qnjaEcG8ZcM1NZt9h9zo70uokaUbB3w9tuCpFE/kc9esCwrdTl
ZJcw8koGrv9Scg5Igofo+CJBa6SV//RBoHzkuM6BkuK811T4kObi53tA6p7/n43f
Z0tVIVsP2c4wf+HjMyNGqgl/WATdjAz5qD/oYUfLVMyIGajH0jS5YxZCdgAOnARP
7H2Q3qZS4FnNdC/zpNEycwBJBpSzKSxggokYLggkU3TUna/A7IjBDaR/nlgQvyg=
=r/uF
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

--===============7236659815749838430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7236659815749838430==--

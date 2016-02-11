From: Sean Heelan <seanheelan@gmail.com>
Subject: Crash on first run of target using
 liblttng-ust-cyg-profile.so, but subsequent runs succeed
Date: Thu, 11 Feb 2016 14:01:18 +0000
Message-ID: <CAL90rL8u1_3ifDL2QzrqrQMp3+68PhOsMfgdsYhceoLX__MAJw__42171.583188656$1455229444$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0809024558=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <seanheelan@gmail.com>) id 1aTroC-0008Rk-AH
 for lttng-dev@lists.lttng.org; Thu, 11 Feb 2016 09:01:30 -0500
Received: by mail-lb0-f172.google.com with SMTP id cw1so28182276lbb.1
 for <lttng-dev@lists.lttng.org>; Thu, 11 Feb 2016 06:01:24 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0809024558==
Content-Type: multipart/alternative; boundary=001a11c349ce0fec2e052b7efc84

--001a11c349ce0fec2e052b7efc84
Content-Type: text/plain; charset=UTF-8

Hi all,

I am running a target within a Docker instance, and tracing function
execution using the latest LTTng release (2.7). The commands I am issuing
look as follows:

----
lttng create cc_session -o bla
lttng enable-event --userspace lttng_ust_cyg_profile:func_entry
lttng start

LD_PRELOAD=liblttng-ust-cyg-profile.so target

lttng stop
lttng destroy
----

When the target is executed it aborts with the following error:

----
php: lttng-ust-comm.c:1582: lttng_ust_init: Assertion `!ret' failed.
----

If I rerun the command it then works fine. In fact, simply doing the
following within the Docker container demonstrates the issue:

----
LD_PRELOAD=liblttng-ust-cyg-profile.so ls
LD_PRELOAD=liblttng-ust-cyg-profile.so ls
----

The first 'ls' will fail at the same point mentioned above, while the
second will succeed. Off the top of my head I'm struggling to come up with
an explanation as to what impact the first execution using LD_PRELOAD would
have on the second. Does it impact a shared lib cache in some way, which
I'm unaware of?

Any assistance would be appreciated!

Sean

--001a11c349ce0fec2e052b7efc84
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I am running a target within a =
Docker instance, and tracing function execution using the latest LTTng rele=
ase (2.7). The commands I am issuing look as follows:</div><div><br></div><=
div>----<br></div><div><div>lttng create cc_session -o bla</div><div>lttng =
enable-event --userspace lttng_ust_cyg_profile:func_entry</div><div>lttng s=
tart</div><div><br></div><div>LD_PRELOAD=3Dliblttng-ust-cyg-profile.so targ=
et</div><div><br></div><div>lttng stop</div><div>lttng destroy</div><div>--=
--</div></div><div><br></div><div>When the target is executed it aborts wit=
h the following error:</div><div><br></div><div>----</div><div>php: lttng-u=
st-comm.c:1582: lttng_ust_init: Assertion `!ret&#39; failed.<br></div><div>=
----</div><div><br></div><div>If I rerun the command it then works fine. In=
 fact, simply doing the following within the Docker container demonstrates =
the issue:</div><div><br></div><div>----</div><div><div>LD_PRELOAD=3Dlibltt=
ng-ust-cyg-profile.so ls</div><div>LD_PRELOAD=3Dliblttng-ust-cyg-profile.so=
 ls</div></div><div>----</div><div><br></div><div>The first &#39;ls&#39; wi=
ll fail at the same point mentioned above, while the second will succeed. O=
ff the top of my head I&#39;m struggling to come up with an explanation as =
to what impact the first execution using LD_PRELOAD would have on the secon=
d. Does it impact a shared lib cache in some way, which I&#39;m unaware of?=
</div><div><br></div><div>Any assistance would be appreciated!</div><div><b=
r>Sean</div><div><br></div><div><br></div></div>

--001a11c349ce0fec2e052b7efc84--


--===============0809024558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0809024558==--

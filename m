From: =?UTF-8?B?6Zmz5LuB5Lm+?= <idryman@gmail.com>
Subject: Spin lock on URCU writers
Date: Fri, 18 Aug 2017 11:54:33 -0700
Message-ID: <CAP8pm97PEpcX_OkofmHf9+BEk96k2DNZ1MaOc16YQRmdNMi_nA__49929.169988218$1503082484$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7498022468509313383=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x22f.google.com (mail-yw0-x22f.google.com
 [IPv6:2607:f8b0:4002:c05::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 3xYshC4NrQzdrx
 for <lttng-dev@lists.lttng.org>; Fri, 18 Aug 2017 18:54:35 +0000 (UTC)
Received: by mail-yw0-x22f.google.com with SMTP id p68so64080333ywg.0
 for <lttng-dev@lists.lttng.org>; Fri, 18 Aug 2017 11:54:35 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============7498022468509313383==
Content-Type: multipart/alternative; boundary="001a11471de2f0f12805570ba8bd"

--001a11471de2f0f12805570ba8bd
Content-Type: text/plain; charset="UTF-8"

Hi all,

I wonder if it is safe to use a spin lock on RCU writers?
Here's the sample code:

#include <stdbool.h>
#include <stdatomic.h>

static atomic_bool lock;

void writer(...) {
  while (atomic_fetch_or(&lock, true)) {}  // spin lock
  // Update rcu guarded pointers (code omitted)
  synchronize_rcu(); // potential dead lock?
  atomic_store(&lock, false);
}

My concern is, in a classical RCU model, the code snippet above may
introduce a dead lock.
Assume we use the pseudo RCU implementation given in the linux kernel
manual:

	void rcu_read_lock(void) { }

	void rcu_read_unlock(void) { }

	void synchronize_rcu(void)
	{
		int cpu;

		for_each_possible_cpu(cpu)
			run_on(cpu);
	}

When we try to run `for_each_possible_cpu(cpu)`, wouldn't it stuck on the
writer's spin lock?

Here's my dead lock scenario.
We have two writer thread T1 T2, they executed in following order:
1. T1 enters writer(...), acquires the spin lock and set it to true
2. T2 enters writer(...), tries to acquire the spin lock but failed. It
spins on the while loop.
3. T1 finishes updating rcu guarded pointer.
4. T1 calls synchronize_rcu(), which should put T1 on each CPU
5. T1 couldn't run on the CPU T2 occupies, because it is in a spin lock.
Therefore we enters a dead lock.

Is this a possible scenario, or it is already addressed in practice?
Maybe the way I write the spin lock is incorrect? Do I have to write it in
this way?

while (atomic_fetch_or(&lock, true)) {
  rcu_thread_offline();
  // other candidates:
  // sched_yield();
  // rcu_quiescent_state();
}

Please help to advice,
Thanks!

Felix

--001a11471de2f0f12805570ba8bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I wonder if it is safe to use a=
 spin lock on RCU writers?</div><div>Here&#39;s the sample code:</div><div>=
<br></div><div>#include &lt;stdbool.h&gt;</div><div>#include &lt;stdatomic.=
h&gt;</div><div><br></div><div>static atomic_bool lock;</div><div><br></div=
><div>void writer(...) {</div><div>=C2=A0 while (atomic_fetch_or(&amp;lock,=
 true)) {} =C2=A0// spin lock</div><div>=C2=A0 // Update rcu guarded pointe=
rs (code omitted)</div><div>=C2=A0 synchronize_rcu(); // potential dead loc=
k?</div><div>=C2=A0 atomic_store(&amp;lock, false);</div><div>}</div><div><=
br></div><div>My concern is, in a classical RCU model, the code snippet abo=
ve may introduce a dead lock.</div><div>Assume we use the pseudo RCU implem=
entation given in the linux kernel manual:</div><div><pre style=3D"word-wra=
p:break-word"><font color=3D"#000000"><span style=3D"white-space:pre-wrap">=
	void rcu_read_lock(void) { }

	void rcu_read_unlock(void) { }

	void synchronize_rcu(void)
	{
		int cpu;

		for_each_possible_cpu(cpu)
			run_on(cpu);
	}<br></span></font></pre>When we try to run `for_each_possible_cpu(cpu)`, =
wouldn&#39;t it stuck on the writer&#39;s spin lock?</div><div><br></div><d=
iv>Here&#39;s my dead lock scenario.</div><div>We have two writer thread T1=
 T2, they executed in following order:</div><div>1. T1 enters writer(...), =
acquires the spin lock and set it to true</div><div>2. T2 enters writer(...=
), tries to acquire the spin lock but failed. It spins on the while loop.</=
div><div>3. T1 finishes updating rcu guarded pointer.</div><div>4. T1 calls=
 synchronize_rcu(), which should put T1 on each CPU</div><div>5. T1 couldn&=
#39;t run on the CPU T2 occupies, because it is in a spin lock.</div><div>T=
herefore we enters a dead lock.</div><div><br></div><div>Is this a possible=
 scenario, or it is already addressed in practice?</div><div>Maybe the way =
I write the spin lock is incorrect? Do I have to write it in this way?</div=
><div><br></div><div>while (atomic_fetch_or(&amp;lock, true)) {</div><div>=
=C2=A0 rcu_thread_offline();</div><div>=C2=A0 // other candidates:</div><di=
v>=C2=A0 // sched_yield();</div><div>=C2=A0 // rcu_quiescent_state();</div>=
<div>}</div><div><br></div><div>Please help to advice,</div><div>Thanks!</d=
iv><div><br></div><div>Felix</div></div>

--001a11471de2f0f12805570ba8bd--

--===============7498022468509313383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7498022468509313383==--

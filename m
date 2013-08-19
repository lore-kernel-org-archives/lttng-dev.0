From: David OShea <David.OShea@quantum.com>
Subject: Re: Questions about LTTNG_UST_REGISTER_TIMEOUT
Date: Mon, 19 Aug 2013 02:48:37 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB24003BD6__46023.8118692816$1376880582$gmane$org@ZURMSG1.QUANTUM.com>
References: <CACsXv7Dfq5h+69JL2ZuiW2xto7Cfm9ABaUKF0eV-yT-8_ooDQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=69431f8a75=david.oshea@quantum.com>)
	id 1VBFWU-0005gP-5X
	for lttng-dev@lists.lttng.org; Sun, 18 Aug 2013 22:48:52 -0400
In-Reply-To: <CACsXv7Dfq5h+69JL2ZuiW2xto7Cfm9ABaUKF0eV-yT-8_ooDQQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?Martin_=DCnsal?= <martinunsal@gmail.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Martin, all,

> -----Original Message-----
> From: Martin =DCnsal [mailto:martinunsal@gmail.com]
> Sent: Saturday, 27 July 2013 4:59 AM
> To: lttng-dev@lists.lttng.org
> Subject: [lttng-dev] Questions about LTTNG_UST_REGISTER_TIMEOUT
> =

> Hi all,
> =

> I am a new lttng-ust user. I would like to leave tracepoints compiled
> into production code. I have verified that inactive tracepoints have
> extremely low overhead, but I am concerned about startup time and
> LTTNG_UST_REGISTER_TIMEOUT. Our typical use case is that we are not
> tracing and there is no lttng-sessiond, we enable tracing only in
> development or QA.
> =

> The specific questions:
> =

> 1) What scenarios might the timeout come into play? I have tested with
> and without lttng-sessiond running and I have seen no more than 10ms
> overhead during app startup caused by lttng. That's no problem, but if
> there is some unforeseen scenario where I introduce 3s overhead I am in
> a world of hurt!

I believe I have seen lttng-sessiond end up in some kind of bad state that =
caused my traced application hit the timeout - I'm fairly certain that ther=
e weren't a large number of other processes talking to lttng-sessiond at th=
e time.  I'm not sure how it got into this state; I know a process with UST=
 trace providers had crashed, perhaps that affected lttng-sessiond somehow.=
  I can reproduce similar behaviour by sending lttng-sessiond the STOP sign=
al, so perhaps lttng-sessiond deadlocked or something.

I found https://bugs.lttng.org/issues/545, my interpretation of which is th=
at once lttng-sessiond is in the above state, you could end up with your ap=
plications completely freezing on startup.  The example in that bug report =
was spawning a large number of processes simultaneously, but I simply used:

for i in $(seq 1 100); do LTTNG_UST_REGISTER_TIMEOUT=3D500 LD_PRELOAD=3D<on=
e of my dynamic trace providers> sleep 1; done

and saw the 62nd invocation of 'sleep' freeze forever.

So whilst I'll be applying the fix for the above bug, I will definitely be =
setting LTTNG_UST_REGISTER_TIMEOUT=3D0 too just in case there are any more =
bugs like this lurking :)

Incidentally I'm still using LTTng 2.1.x.

Regards,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any dis=
closure, copying, or further distribution of confidential information is no=
t permitted unless such privilege is explicitly granted in writing by Quant=
um. Quantum reserves the right to have electronic communications, including=
 email and attachments, sent across its networks filtered through anti viru=
s and spam software programs and retain such messages in order to comply wi=
th applicable data security and retention requirements. Quantum is not resp=
onsible for the proper and complete transmission of the substance of this c=
ommunication or for any delay in its receipt.

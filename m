From: David OShea <David.OShea@quantum.com>
Subject: Re: dlopen, gcc -l and LD_PRELOAD
Date: Tue, 19 Mar 2013 04:54:05 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB23FCD7EF__27406.8057108254$1363669670$gmane$org@ZURMSG1.QUANTUM.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD027A2C@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxvm5=mms0BwFtDEy8CKuYOM08K7EYCddKWoRY2VSbxV1Q@mail.gmail.com>
	<48CF5AC71E61DB46B70D0F388054EFFD028674@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<CA+jJMxvD+g9kPeeqP5hbELOk40qMwD-+UBfMUVNRQfypXk_ycw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=17904b0364=david.oshea@quantum.com>)
	id 1UHolF-000163-Nu
	for lttng-dev@lists.lttng.org; Tue, 19 Mar 2013 01:06:57 -0400
In-Reply-To: <CA+jJMxvD+g9kPeeqP5hbELOk40qMwD-+UBfMUVNRQfypXk_ycw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>, "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi all,

> -----Original Message-----
> From: J=E9r=E9mie Galarneau [mailto:jeremie.galarneau@efficios.com]
> Sent: Tuesday, 19 March 2013 7:28 AM
> To: Thibault, Daniel
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] dlopen, gcc -l and LD_PRELOAD


> > Good question. I think this problem has been fixed as part of the 2.1
> release. However, I do know there are other issues related to
> "dlopen()"-ing probe providers; details on the bug tracker[1].
> >
> > J=E9r=E9mie
> > [1] https://bugs.lttng.org/issues/447
> > -----Fin du message d'origine-----
> >
> >    Bug 447 concerns dlclose(), not dlopen().  It's a legitimate
> concern (that has yet to be addressed, it seems), but it has nothing to
> do with potential delays or deadlocks upon calling dlopen() on a
> tracepoint provider.

[...]

> Typically, you would want to do one or the other [dlopen or
> LD_PRELOAD]. But to answer your question, yes, this would workaround
> the locking problem described in the man page that affected prior
> versions of lttng-ust (before 2.1).

FYI I mentioned my email to this list dated 25/Feb/2013 that:

"I noticed that commit ID b834deadbfa8a78ae1d00440fd91c41dfd351eba changed =
README to remove a note suggesting that dlopen() not be used.  It looks lik=
e the same change should be made to doc/man/lttng-ust.3, which still sugges=
ts that you not use dlopen()."

Just a reminder that it does appear to have been intended that that note be=
 removed, so it should probably be disregarded.

Also, if anyone is able to provide explanations for the questions in my pre=
vious email, that might serve to address the topic of this thread too.

Thanks,
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

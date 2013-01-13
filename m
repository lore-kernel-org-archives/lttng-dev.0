From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Arrays printed in hex
Date: Sun, 13 Jan 2013 12:59:18 -0500
Message-ID: <20130113175918.GC3917__13710.7605733492$1358100005$gmane$org@Krystal>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F8AEE2@ZURMSG1.QUANTUM.com>
	<20130113175839.GB3917@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TuRq2-00064G-G0
	for lttng-dev@lists.lttng.org; Sun, 13 Jan 2013 12:59:18 -0500
Content-Disposition: inline
In-Reply-To: <20130113175839.GB3917@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * David OShea (David.OShea@quantum.com) wrote:
> > Hi all,
> > 
> > In lttng-ust 2.0.5, tracepoint.h's comments include:
> > 
> > """
> >  *         * Integer, printed in base 10 * 
> >  *         ctf_integer(int, field_a, arg0)
> >  *
> >  *         * Integer, printed with 0x base 16 * 
> >  *         ctf_integer_hex(unsigned long, field_d, arg1)
> > [...]
> >  *         * Array sequence of signed integer values * 
> >  *         ctf_array(long, field_f, arg4, FIXED_LEN4)
> >  *         ctf_sequence(long, field_g, arg4, size_t, arg4_len)
> > """
> > 
> > Could _hex versions of ctf_array() and ctf_sequence() be easily added,
> > where all the elements of the array/sequence would be output in hex by
> > babeltrace?
> 
> Yes, this would just need to be added to lttng/ust-tracepoint-event*.h
> file. Patches are welcome.

If you cannot write a patch, please open a feature request against
lttng-ust on bugs.lttng.org

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Thanks in advance,
> > David
> > 
> > ----------------------------------------------------------------------
> > The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

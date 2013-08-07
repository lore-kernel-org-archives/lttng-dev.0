From: Stefan Seefeld <stefan@seefeld.name>
Subject: Re: [PATCH lttng-ust] Add trace instrumentation
 for	some pthread functions.
Date: Wed, 07 Aug 2013 12:38:58 -0400
Message-ID: <52027822.7000300__28799.9902423055$1375893602$gmane$org@seefeld.name>
References: <5202482B.2010705@mentor.com> <52025427.5080002@mentor.com>
	<20130807143346.GA542@Krystal> <520262E8.5010106@mentor.com>
	<20130807151903.GA1035@Krystal> <52026AD7.7000103@mentor.com>
	<20130807155228.GC1035@Krystal> <52026F42.4050005@mentor.com>
	<20130807161241.GB1336@Krystal> <520274F3.3080505@mentor.com>
	<20130807163153.GA2194@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stefan.seefeld@gmail.com>) id 1V76lQ-0001fQ-5H
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 12:39:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2097801pbb.5
	for <lttng-dev@lists.lttng.org>; Wed, 07 Aug 2013 09:39:02 -0700 (PDT)
Received: from [192.168.2.10] (bas2-montreal29-1279583707.dsl.bell.ca.
	[76.68.229.219])
	by mx.google.com with ESMTPSA id a5sm9175683pbw.4.2013.08.07.09.39.00
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=RC4-SHA bits=128/128);
	Wed, 07 Aug 2013 09:39:01 -0700 (PDT)
In-Reply-To: <20130807163153.GA2194@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 08/07/2013 12:31 PM, Mathieu Desnoyers wrote:
> * Stefan Seefeld (stefan_seefeld@mentor.com) wrote:
>> On 08/07/2013 12:12 PM, Mathieu Desnoyers wrote:
>>
>>> Please note that as soon as you get my acked-by, you can consider this
>>> patch accepted. It's just that we don't have the staging branches to
>>> keep them around, nor the manpower to maintain a 3rd branch in parallel
>>> with the current stable+rc.
>>>
>>> Thoughts ?
>> I understand if it makes things easier for you as maintainer if you ask
>> contributors to do the rebase before their (approved) patches are to be
>> merged. But your wording seemed to suggest that I should resend the
>> actual patch, not regenerate it after rebasing to a future master, which
>> confused me as in that case I'd need to keep around a free-floating
>> patch that is neither version-controlled nor archived.
> I'm OK with contributors rebasing a patch before resubmission, of
> course. However, if the rebase required any change at all to the patch,
> the "acked-by" tags should be removed, and the fact that it's been
> accepted and then rebased (with changes) should be pointed out in the
> changelog, ideally with a quick summary of the changes required for the
> rebase. This should make the merge process quick and straightforward,
> without risks of us missing an issue introduced by the rebase.
>
> Does it make sense ?

OK. You are right, the patch may not actually require any change, given
that it's (mostly) new files.

Thanks,
    Stefan

-- 

      ...ich hab' noch einen Koffer in Berlin...

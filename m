From: Stefan Seefeld <stefan@seefeld.name>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Wed, 07 Aug 2013 10:01:54 -0400
Message-ID: <52025352.5020404__30043.0605457679$1375884173$gmane$org@seefeld.name>
References: <alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
	<51FA9AD8.4010502@mentor.com>
	<CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg@mail.gmail.com>
	<20130803011841.GE9033@Krystal> <51FFBD46.5030105@mentor.com>
	<20130807014241.GH19407@Krystal> <52024D88.8090409@seefeld.name>
	<20130807135757.GA32387@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stefan.seefeld@gmail.com>) id 1V74JQ-0001C7-Kr
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 10:02:09 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so1939037pbc.9
	for <lttng-dev@lists.lttng.org>; Wed, 07 Aug 2013 07:01:59 -0700 (PDT)
In-Reply-To: <20130807135757.GA32387@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 08/07/2013 09:57 AM, Mathieu Desnoyers wrote:
> * Stefan Seefeld (stefan@seefeld.name) wrote:
>>
>> Sorry, I'm confused. Where can I find this commit, i.e. what repo, what
>> branch ? I can't see it anywhere ?
> See
>
> https://github.com/efficios/memleak-finder/commits/master

Oh, sorry, I had been looking in the lttng repo. I see it now.
Yes, that looks good. I'll revise my malloc patch accordingly.

    Stefan

-- 

      ...ich hab' noch einen Koffer in Berlin...

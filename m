From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: Compiliing LTTng-modules 2.1 with a 3.9.4 kernel
Date: Fri, 07 Jun 2013 14:18:27 -0400
Message-ID: <51B223F3.70204__12390.6926870861$1370629147$gmane$org@gmail.com>
References: <51B220F3.70901@gmail.com> <20130607181235.GA32244@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Ul1FC-0004Kk-HH
	for lttng-dev@lists.lttng.org; Fri, 07 Jun 2013 14:18:34 -0400
Received: by mail-ie0-f177.google.com with SMTP id u16so11451913iet.36
	for <lttng-dev@lists.lttng.org>; Fri, 07 Jun 2013 11:18:29 -0700 (PDT)
In-Reply-To: <20130607181235.GA32244@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2013-06-07 14:12, Mathieu Desnoyers wrote:
> Please let me know if anything is missing,
Good, now it just miss the changes on
instrumentation/events/lttng-module/block.h
There are scatered along a long suite of commit and revert on the master
branch

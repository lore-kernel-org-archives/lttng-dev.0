From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [LTTng-module patch] Update syscalls extraction
 with 3.10.0-rc7 version
Date: Fri, 05 Jul 2013 11:38:20 -0400
Message-ID: <51D6E86C.8080408__32635.834607254$1373038742$gmane$org@gmail.com>
References: <1372692535-4910-1-git-send-email-yannick.brosseau@gmail.com>
	<20130705151617.GA23889@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Uv85c-00067P-0q
	for lttng-dev@lists.lttng.org; Fri, 05 Jul 2013 11:38:28 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so5418806iec.7
	for <lttng-dev@lists.lttng.org>; Fri, 05 Jul 2013 08:38:22 -0700 (PDT)
In-Reply-To: <20130705151617.GA23889@Krystal>
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

On 2013-07-05 11:16, Mathieu Desnoyers wrote:
> * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
>> > Add some previsously unknown syscalls
> please submit the generate headers script modification in one patch,
> then the automatically generated files into a different patch, and then
> the updated override headers in another.
I did not change the override, just renamed the file, do you still need
that as a separate patch?

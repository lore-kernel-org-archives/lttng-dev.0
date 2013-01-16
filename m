From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [lttng-tools PATCH] Add support for kernel uprobes
Date: Wed, 16 Jan 2013 11:55:27 -0500
Message-ID: <50F6DB7F.5070202__2436.11229020662$1358355387$gmane$org@gmail.com>
References: <1358132617-18443-1-git-send-email-yannick.brosseau@gmail.com>
	<20130116155238.GA11695@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TvWHA-0006CL-4p
	for lttng-dev@lists.lttng.org; Wed, 16 Jan 2013 11:55:44 -0500
Received: by mail-qc0-f179.google.com with SMTP id b14so1027096qcs.10
	for <lttng-dev@lists.lttng.org>; Wed, 16 Jan 2013 08:55:38 -0800 (PST)
In-Reply-To: <20130116155238.GA11695@Krystal>
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

On 2013-01-16 10:52, Mathieu Desnoyers wrote:
> * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
>> Inspired by the k*probe support.
>>
>> It add a new option to enable-event --uprobe which require a path name
>> and an offset in the specified file.
>>
>> (The file Documentation/trace/uprobetracer.txt in the kernel source provides
>> and example on how to extract the offset for a symbol in a program)
> Asking Masami and looking at perf might help us add support for lookup
> by file/lineno (using dwarf info). I think in terms of usability this is
> really important, and should appear in tools at the same time as the
> basic feature based on file/offset (or at least appear in the same
> LTTng release).
>
> We should keep in mind that liblttng-ctl is LGPLv2.1, so we cannot use
> perf code as-is without asking for the author's permission first.
> Nothing prevents us from writing this support ourself if need be though.
Ok, great, I'll look into it.

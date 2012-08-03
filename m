From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: Babeltrace API timestamp manipulation changes
Date: Fri, 03 Aug 2012 15:57:38 -0400
Message-ID: <501C2D32.5090907__4890.97143658928$1344023886$gmane$org@gmail.com>
References: <501C2627.6060401@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f176.google.com ([209.85.161.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SxO0I-0007YQ-QM
	for lttng-dev@lists.lttng.org; Fri, 03 Aug 2012 15:57:46 -0400
Received: by ggcs6 with SMTP id s6so1545247ggc.35
	for <lttng-dev@lists.lttng.org>; Fri, 03 Aug 2012 12:57:41 -0700 (PDT)
In-Reply-To: <501C2627.6060401@efficios.com>
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

On 2012-08-03 15:27, Julien Desfossez wrote:
> Hi,
>
> Previously, the Babeltrace API forced the user to manipulate "raw
> timestamps" to seek, to get the timestamp begin and end of a trace, etc.
>
> This raw timestamp represented the cycle value scaled with the frequency
> but did not meant anything to the user and was likely to cause problem
> when dealing with traces recorded with different clock sources.
>
> The new patches commited in Babeltrace today removed the notion of the
> raw clock-source all over the code, and now the users can manipulate
> real timestamps (with the timezone offset applied) or cycle values if
> they want more fine-grained control on a specific trace.
>
> This means some API changes :
> - the "seek_time" member of the bt_iter_pos structure now takes real
> timestamp (with the offset applied)
> - the functions "bt_ctf_get_timestamp_raw" is removed
> - the funtion "bt_ctf_get_timestamp" is replaced by
> "bt_ctf_get_real_timestamp"
> - the function "bt_ctf_get_cycles_timestamp" is added
>
Why not simply calling them
bt_ctf_get_timestamp and bt_ctf_get_cycles  ?

Yannick

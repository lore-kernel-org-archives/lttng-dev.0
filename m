From: Simon Marchi <simon.marchi@efficios.com>
Subject: Re: [PATCH babeltrace v3] Fix: bitfield: left shift
 undefined behavior
Date: Thu, 9 May 2019 10:19:23 -0400
Message-ID: <207dfb5a-d99a-ecab-3080-16ba3e6e998a__20105.9881759406$1557411592$gmane$org@efficios.com>
References: <20190508222318.6014-1-mathieu.desnoyers@efficios.com>
 <cbd49a5b-b955-e50c-46e0-c24507108b85@simark.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 450FpW3ys1z1LG2
 for <lttng-dev@lists.lttng.org>; Thu,  9 May 2019 10:19:31 -0400 (EDT)
In-Reply-To: <cbd49a5b-b955-e50c-46e0-c24507108b85@simark.ca>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simark@simark.ca>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2019-05-09 10:02 a.m., Simon Marchi wrote:
> I might have more cases for you to investigate :)
> 
> Can you try building with -fsanitize=undefined and run test_bitfield? I get some:
> 
> /home/smarchi/src/babeltrace/tests/lib/test_bitfield.c:222:4: runtime error: left shift of negative value -1
> 
> Which would hint that we are missing a cast before a shift.
> 
> Simon

I digged a bit, and it's these lines

  ___v >>= final;

  ___v <<= final;

in _bt_piecewise_lshift and _bt_piecewise_rshift.

Simon

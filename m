From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH v2 lttng-tools] lttng cli: Accept human
 readable sizes for --subbuf-size
Date: Mon, 8 Apr 2013 10:33:49 -0400
Message-ID: <CAFXXi0n6=CfcRWODv9oY0zA7ypik58dHtxfjqDcHD5=bnSLgaQ__23976.7355881215$1365437216$gmane$org@mail.gmail.com>
References: <1365039047-22417-1-git-send-email-simon.marchi@polymtl.ca>
	<20130406082614.GA25199@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UPD9N-0006V9-Da
	for lttng-dev@lists.lttng.org; Mon, 08 Apr 2013 10:34:25 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so5244818iad.26
	for <lttng-dev@lists.lttng.org>; Mon, 08 Apr 2013 07:34:19 -0700 (PDT)
In-Reply-To: <20130406082614.GA25199@Krystal>
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

>>  #define _GNU_SOURCE
>> -#include <stdlib.h>
>> +#include <assert.h>
>>  #include <ctype.h>
>>  #include <limits.h>
>> +#include <regex.h>
>> +#include <stdlib.h>
>
> any reason why stdlib is moved here ?

I put them in alphabetical order instead of random order.

Thanks for the comments, I will make the changes.

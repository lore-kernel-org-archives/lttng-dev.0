From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Do not install health
 tests helper libraries
Date: Tue, 06 Nov 2012 14:56:19 -0500
Message-ID: <50996B63.2020602__30521.3657477454$1352231815$gmane$org@efficios.com>
References: <1352150413-16685-1-git-send-email-christian.babeux@efficios.com>
	<20121105221103.GB13619@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TVpG2-0001UC-Kx
	for lttng-dev@lists.lttng.org; Tue, 06 Nov 2012 14:56:22 -0500
In-Reply-To: <20121105221103.GB13619@Krystal>
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

Merged!

Thanks!
David

Mathieu Desnoyers:
> * Christian Babeux (christian.babeux@efficios.com) wrote:
>> The libraries libhealthexit and libhealthstall should not be
>> installed on the user system. They are only useful for the
>> health check tests.
>>
>> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> 
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
>> ---
>>  tests/tools/health/Makefile.am | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tests/tools/health/Makefile.am b/tests/tools/health/Makefile.am
>> index 9fab582..d1d4919 100644
>> --- a/tests/tools/health/Makefile.am
>> +++ b/tests/tools/health/Makefile.am
>> @@ -10,8 +10,6 @@ endif
>>  
>>  UTILS=
>>  
>> -lib_LTLIBRARIES=libhealthexit.la libhealthstall.la
>> -
>>  # Health thread exit ld_preloaded test lib
>>  libhealthexit_la_SOURCES=health_exit.c
>>  libhealthexit_la_LDFLAGS= -module
>> @@ -21,6 +19,7 @@ libhealthstall_la_SOURCES=health_stall.c
>>  libhealthstall_la_LDFLAGS= -module
>>  
>>  noinst_PROGRAMS = health_check
>> +noinst_LTLIBRARIES = libhealthexit.la libhealthstall.la
>>  
>>  health_check_SOURCES = health_check.c $(UTILS)
>>  health_check_LDADD = $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
>> -- 
>> 1.8.0
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

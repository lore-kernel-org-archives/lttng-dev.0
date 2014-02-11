From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Tue, 11 Feb 2014 15:55:56 -0500
Message-ID: <52FA8E5C.40203__26246.3774918162$1392152234$gmane$org@mentor.com>
References: <52F55511.2080309@mentor.com>
	<1380151240.21051.1391875592403.JavaMail.zimbra@efficios.com>
	<52F66118.5010003@mentor.com>
	<905376946.21151.1391898148330.JavaMail.zimbra@efficios.com>
	<52F9746F.5070302@mentor.com>
	<1494953964.23233.1392151900002.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1WDKNA-0005L7-SA
	for lttng-dev@lists.lttng.org; Tue, 11 Feb 2014 15:56:10 -0500
In-Reply-To: <1494953964.23233.1392151900002.JavaMail.zimbra@efficios.com>
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

On 02/11/2014 03:51 PM, Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Stefan Seefeld" <stefan_seefeld@mentor.com>

>> I'm actually not quite sure what behaviour I would prefer as a user. My
>> library-author feeling tell me to not abort the process, but return an
>> error condition (i.e., NULL) and let the caller take care of how to
>> handle it.
>> On the other hand, not finding malloc certainly is a critical error.
>> And, this isn't a library in the proper sense, but a preloaded wrapper,
>> so users can always re-run his apps without it.
>> Hmm...
> 
> I'm tempted to go the shortcut route (abort()) since this is really just a
> wrapper.

OK, fair enough.

> I'm attaching an updated version, which fixes a couple of incorrect
> handling of the realloc case for the static allocator. I did not add yet the
> mmap() stuff, since it adds a bit of complexity to the patch, and I would be
> tempted to keep things simple in -rc. I really doubt that real-life use-cases
> will have error messages going beyond 4kB. And if it ever happens, we'll hit a
> abort() within the wrapper, and it will be easy to fix. I'm tempted to leave
> this without the mmap stuff for 2.4, so we don't add regressions late in the
> cycle, is that OK with you ?

Sounds good. Thanks,

		Stefan


-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/

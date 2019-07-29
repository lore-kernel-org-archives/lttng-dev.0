From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: [lttng-ust][PATCH V2] Add config time check for new
 gettid API
Date: Mon, 29 Jul 2019 09:48:52 -0400
Message-ID: <61c3cf80-f730-5253-ec03-bc35eaad2594__1696.75627710006$1564408162$gmane$org@gydle.com>
References: <20190726190223.38027-1-raj.khem@gmail.com>
 <8c60fd3c-398e-98ef-796b-028bf1fb5647@gydle.com>
 <CAMKF1sqVkKeEYMn1sPWgKfqFuaEnk68Hd4MfccUJKW4UkT0L=Q@mail.gmail.com>
 <dd43d88d-15e5-cafe-b2a5-c2be84ac361d@gydle.com>
 <CAMKF1so6z7dk7GkpVLR9bp72c2AD47+j9Cd9xOw=fw8+EG7oQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 45y1J20lHxz188p
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 09:49:05 -0400 (EDT)
In-Reply-To: <CAMKF1so6z7dk7GkpVLR9bp72c2AD47+j9Cd9xOw=fw8+EG7oQg@mail.gmail.com>
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
To: Khem Raj <raj.khem@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2019-07-26 5:27 p.m., Khem Raj wrote:
>>
>> I don't see the definition of gettid().
> 
> its a syscall wrapper which is generated during build from
> sysdeps/unix/sysv/linux/syscalls.list
> 

OK, now I understand, thanks !

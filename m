From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: [lttng-ust][PATCH V2] Add config time check for new
 gettid API
Date: Fri, 26 Jul 2019 17:09:05 -0400
Message-ID: <dd43d88d-15e5-cafe-b2a5-c2be84ac361d__19570.5502106406$1564175374$gmane$org@gydle.com>
References: <20190726190223.38027-1-raj.khem@gmail.com>
 <8c60fd3c-398e-98ef-796b-028bf1fb5647@gydle.com>
 <CAMKF1sqVkKeEYMn1sPWgKfqFuaEnk68Hd4MfccUJKW4UkT0L=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 45wMCK0p4fz1Fk0
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jul 2019 17:09:15 -0400 (EDT)
In-Reply-To: <CAMKF1sqVkKeEYMn1sPWgKfqFuaEnk68Hd4MfccUJKW4UkT0L=Q@mail.gmail.com>
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



On 2019-07-26 4:55 p.m., Khem Raj wrote:
> On Fri, Jul 26, 2019 at 12:23 PM Sebastien Boisvert <sboisvert@gydle.com> wrote:
>>
>>
>>
>> On 2019-07-26 3:02 p.m., Khem Raj wrote:
>>> glibc 2.30 introduced this function see [1]
>>> so it's best to detect it
>>> and provide fallback only if its not present
>>
>> nit:
>>
>> -if its not present
>> +if it's not present
>>
> 
> I sent a v3 with this fixed.
> 
>> I cloned the git repository of the glibc, but I could not find
>> the definition of gettid().
>>
>> Do you know where it is located in glibc ?
>>
> see
> https://sourceware.org/git/?p=glibc.git;a=commit;h=1d0fc213824eaa2a8f8c4385daaa698ee8fb7c92
> 

In the commit diff at https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=1d0fc213824eaa2a8f8c4385daaa698ee8fb7c92;hp=f289e656ec8221756519a601042bc9fbe1b310fb
I don't see the definition of gettid().

I see the declaration.

There are a bunch of *ABI changes (*.abilist), and test changes (*tst-*).


>> Thanks.
>>
>>>
>>> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=6399
>>>
>>> Upstream-Status: Submitted [https://lists.lttng.org/pipermail/lttng-dev/2019-July/029131.html]
>>>
>>> Signed-off-by: Khem Raj <raj.khem@gmail.com>
>>> ---
>>> v2: Fix typos in commit message
>>>
>>>  configure.ac            | 1 +
>>>  include/lttng/ust-tid.h | 7 +++++--
>>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 7fa059a..b1099c1 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -137,6 +137,7 @@ AC_CHECK_FUNCS([ \
>>>       clock_gettime \
>>>       ftruncate \
>>>       getpagesize \
>>> +     gettid \
>>>       gettimeofday \
>>>       localeconv \
>>>       memchr \
>>> diff --git a/include/lttng/ust-tid.h b/include/lttng/ust-tid.h
>>> index e669d7e..7995c78 100644
>>> --- a/include/lttng/ust-tid.h
>>> +++ b/include/lttng/ust-tid.h
>>> @@ -26,7 +26,10 @@
>>>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>>>   * SOFTWARE.
>>>   */
>>> -
>>> +#include <config.h>
>>> +#if HAVE_GETTID
>>> +#include <unistd.h>
>>> +#else
>>>  #ifdef __linux__
>>>  #include <syscall.h>
>>>  #endif
>>> @@ -49,5 +52,5 @@ static inline pid_t gettid(void)
>>>       return getpid();
>>>  }
>>>  #endif
>>> -
>>> +#endif /* HAVE_GETTID */
>>>  #endif /* _LTTNG_UST_TID_H */
>>>

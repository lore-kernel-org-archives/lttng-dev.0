From: Richard Henderson <rth@twiddle.net>
Subject: Multiple local register variables w/ same register
Date: Wed, 20 Nov 2013 07:56:57 +1000
Message-ID: <528BDEA9.1050708@twiddle.net>
References: <52803E5D.3050109@mentor.com> <52851395.3010306@mentor.com> <67652521.68027.1384482849638.JavaMail.zimbra@efficios.com> <1691607547.70809.1384874952002.JavaMail.zimbra@efficios.com> <20131119160502.GG11778@mudshark.cambridge.arm.com> <1656507422.70913.1384880540574.JavaMail.zimbra@efficios.com> <20131119173312.GP16796@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <gcc-return-181039-gcc=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-##L=##H@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
In-Reply-To: <20131119173312.GP16796@laptop.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>, lttng-dev@lists.lttng.org, Nathan Lynch <Nathan_Lynch@mentor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jakub Jelinek <jakub@redhat.com>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
List-Id: lttng-dev@lists.lttng.org

On 11/20/2013 03:33 AM, Peter Zijlstra wrote:
> On Tue, Nov 19, 2013 at 05:02:20PM +0000, Mathieu Desnoyers wrote:
>> Unfortunately I don't have a ARM cross-compiler setup ready. Nathan could test
>> it for us though.
>>
>> It might shuffle things around enough to work around the issue, but with the
>> approach you propose, I would be concerned about the compiler being within
>> its rights to reorder the code into the following sequence:
>>
>> struct thread_info *ptra, *ptrb;
>>
>> ptra = current_thread_info();
>> /*
>>  * each current_thread_info() would have a clobber on *sp, which orders
>>  * those two wrt each other.
>>   */
>> ptrb = current_thread_info();
>>
>> load from ptra->preempt_count;
>> /*
>>  * however, the following accesses that depend on ptra and ptrb could be
>>  * reordered if the compiler has no way to know that ptra and ptrb are
>>  * aliased.
>>  */
>> store to ptrb->preempt_count;
>>
>> One question that might be worth asking: with the local register variable
>> extension (http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/Local-Reg-Vars.html#Local-Reg-Vars)
>> (thanks to Jakub for the pointer), should the compiler consider two variables
>> bound to the same register as being aliased or not ? AFAIU, local reg vars appear
>> to be architecture-specific, so maybe there is something fishy on ARM ?

It appears not:

int __attribute__((noinline)) f(void)
{
  {
    register int x __asm__("eax");
    x = 1;
  }
  {
    register int y __asm__("eax");
    return ++y;
  }
}

extern void abort(void);

int main(void)
{
  if (f() != 2)
    abort();
  return 0;
}

Anyone see anything wrong with the testcase?  Do we thing this sort of thing
ought to work, perhaps with scopes lengthened?


r~

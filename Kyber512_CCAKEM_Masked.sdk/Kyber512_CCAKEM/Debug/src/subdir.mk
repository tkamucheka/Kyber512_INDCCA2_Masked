################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

CC_SRCS += \
../src/main.cc \
../src/prng.cc \
../src/simple_serial.cc \
../src/simple_serial_kyber512.cc \
../src/utilities.cc 

CC_DEPS += \
./src/main.d \
./src/prng.d \
./src/simple_serial.d \
./src/simple_serial_kyber512.d \
./src/utilities.d 

OBJS += \
./src/main.o \
./src/prng.o \
./src/simple_serial.o \
./src/simple_serial_kyber512.o \
./src/utilities.o 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cc
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze g++ compiler'
	mb-g++ -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../Kyber512_CCAKEM_bsp/microblaze_0/include -mlittle-endian -mcpu=v11.0 -mxl-soft-mul -Wl,--no-relax -ffunction-sections -fdata-sections -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '



import React, { useState, useEffect } from 'react';

const App = () => {
  const [test, setTest] = useState('initial value');
  const [test2, setTest2] = useState('initial value');

  // useEffect(() => {
  //   console.log('state가 변경될 때 마다 호출!');
  //   return () => {
  //     console.log('언마운트 시 호출!');
  //   };
  // });

  // useEffect(() => {
  //   console.log('딱 한번만 호출');
  // }, []);

  // useEffect(() => {
  //   console.log('test state에 대해서만 호출!');
  // }, [test]);

  // useEffect(() => {
  //   console.log('test2 state에 대해서만 호출!');
  // }, [test2]);

  const [test3, setTest3] = useState('initial state');

  useEffect(() => {
    console.log('첫 렌더링에만 호출');
    return () => {
      console.log('마지막 언마운트 시 호출');
    };
  }, []);

  return (
    <div>
      <p>{test}</p>
      <input
        onChange={(e) => {
          setTest(e.target.value);
        }}
      />
    </div>
  );
};
export default App;
